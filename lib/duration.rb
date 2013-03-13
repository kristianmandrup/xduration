# -*- encoding:  utf-8 -*-
require 'i18n'
require 'active_support/core_ext'

if defined?(Rails) && Rails::VERSION::STRING >= '3.1'
  require 'duration/rails/engine' 
end

# Duration objects are simple mechanisms that allow you to operate on durations
# of time.  They allow you to know how much time has passed since a certain
# point in time, or they can tell you how much time something is (when given as
# seconds) in different units of time measurement.  Durations would particularly
# be useful for those scripts or applications that allow you to know the uptime
# of themselves or perhaps provide a countdown until a certain event.
class Duration
  include Comparable

  UNITS = [:seconds, :minutes, :hours, :days, :weeks, :months, :years]

  MULTIPLES = {:seconds => 1,
               :minutes => 60,
               :hours   => 3600,
               :days    => 86400,
               :weeks   => 604800,
               :months  => 2592000, # 30 days
               :years   => 31557600, # 365.25 days
               :second  => 1,
               :minute  => 60,
               :hour    => 3600,
               :day     => 86400,
               :week    => 604800,
               :month   => 2592000,
               :year    => 31557600}

  attr_reader :years, :months, :weeks, :days, :hours, :minutes, :seconds, :total

  # Initialize a duration. 'args' can be a hash or anything else.  If a hash is
  # passed, it will be scanned for a key=>value pair of time units such as those
  # listed in the Duration::UNITS array or Duration::MULTIPLES hash.
  #
  # If anything else except a hash is passed, #to_i is invoked on that object
  # and expects that it return the number of seconds desired for the duration.
  def initialize(args = 0)
    if args.kind_of?(Hash)
      @seconds = 0
      MULTIPLES.each do |unit, multiple|
        unit = unit.to_sym
        @seconds += args[unit].to_i * multiple if args.key?(unit)
      end
    else
      @seconds = args.to_i
    end

    calculate!
  end

  # Compare this duration to another (or objects that respond to #to_i)
  def <=>(other)
    return false unless other.is_a?(Duration)
    @total <=> other.to_i
  end

  def +(other)
    Duration.new(@total + other.to_i)
  end

  def -(other)
    Duration.new(@total - other.to_i)
  end

  def *(other)
    Duration.new(@total * other.to_i)
  end

  def /(other)
    Duration.new(@total / other.to_i)
  end

  def %(other)
    Duration.new(@total % other.to_i)
  end
  
  %w(minutes hours days weeks months years).each do |meth|
    define_method("total_#{meth}") { @total / MULTIPLES[meth.to_sym] }
  end

  # Formats a duration in ISO8601.
  # @see http://en.wikipedia.org/wiki/ISO_8601#Durations
  def iso8601
    output = 'P'

    output << "#{years}Y" if years > 0
    output << "#{months}M" if months > 0
    output << "#{weeks}W" if weeks > 0
    output << "#{days}D" if days > 0
    if seconds > 0 || minutes > 0 || hours > 0
      output << 'T'
      output << "#{hours}H" if hours > 0
      output << "#{minutes}M" if minutes > 0
      output << "#{seconds}S" if seconds > 0
    end

    output
  end

  # @return true if total is 0
  def blank?
    @total == 0
  end

  # @return true if total different than 0
  def present?
    !blank?
  end

  # Format a duration into a human-readable string.
  #
  #   %w   => weeks
  #   %d   => days
  #   %h   => hours
  #   %m   => minutes
  #   %s   => seconds
  #   %td  => total days
  #   %th  => total hours
  #   %tm  => total minutes
  #   %ts  => total seconds
  #   %t   => total seconds
  #   %H   => zero-padded hours
  #   %M   => zero-padded minutes
  #   %S   => zero-padded seconds
  #   %~s  => locale-dependent "seconds" terminology
  #   %~m  => locale-dependent "minutes" terminology
  #   %~h  => locale-dependent "hours" terminology
  #   %~d  => locale-dependent "days" terminology
  #   %~w  => locale-dependent "weeks" terminology
  #   %tdu => total days with locale-dependent unit
  #   %thu => total hours with locale-dependent unit
  #   %tmu => total minutes with locale-dependent unit
  #   %tsu => total seconds with locale-dependent unit
  #
  # You can also use the I18n support.
  # The %~s, %~m, %~h, %~d and %~w can be translated with I18n.
  # If you are using Ruby on Rails, the support is ready out of the box, so just change your locale file. Otherwise you can try:
  #
  #   I18n.load_path << "path/to/your/locale"
  #   I18n.locale = :your_locale
  # 
  # And you must use the following structure (example) for your locale file:
  #   pt:
  #     ruby_duration:
  #       second: segundo
  #       seconds: segundos
  #       minute: minuto
  #       minutes: minutos
  #       hour: hora
  #       hours: horas
  #       day: dia
  #       days: dias
  #       week: semana
  #       weeks: semanas
  #
  def format(format_str)
    identifiers = {
      'y'  => @years,
      'o'  => @months,
      'w'  => @weeks,
      'd'  => @days,
      'h'  => @hours,
      'm'  => @minutes,
      's'  => @seconds,
      'ty' => Proc.new { total_years },
      'to' => Proc.new { total_months },
      'tw' => Proc.new { total_weeks },
      'td' => Proc.new { total_days },
      'th' => Proc.new { total_hours },
      'tm' => Proc.new { total_minutes },
      'ts' => @total,
      't'  => @total,
      'H'  => @hours.to_s.rjust(2, '0'),
      'M'  => @minutes.to_s.rjust(2, '0'),
      'S'  => @seconds.to_s.rjust(2, '0'),
      '~s' => i18n_for(:second),
      '~m' => i18n_for(:minute),
      '~h' => i18n_for(:hour),
      '~d' => i18n_for(:day),
      '~w' => i18n_for(:week),
      '~o' => i18n_for(:month),
      '~y' => i18n_for(:year),
      'tyr'=> Proc.new { "#{total_years} #{i18n_for(:total_year)}"},
      'tmo'=> Proc.new { "#{total_months} #{i18n_for(:total_month)}"},
      'twk'=> Proc.new { "#{total_weeks} #{i18n_for(:total_week)}"},
      'tdu'=> Proc.new { "#{total_days} #{i18n_for(:total_day)}"},
      'thu'=> Proc.new { "#{total_hours} #{i18n_for(:total_hour)}"},
      'tmu'=> Proc.new { "#{total_minutes} #{i18n_for(:total_minute)}"},
      'tsu'=> Proc.new { "#{total} #{i18n_for(:total)}"}
    }

    format_str.gsub(/%?%(y|o|w|d|h|m|s|t([ydhms]u?)?|H|M|S|~(?:s|m|h|d|w|o|y))/) do |match|
      match['%%'] ? match : (identifiers[match[1..-1]].class == Proc ? identifiers[match[1..-1]].call : identifiers[match[1..-1]])
    end.gsub('%%', '%')
  end

  alias_method :to_i, :total
  alias_method :strftime, :format
  
private

  # Calculates the duration from seconds and figures out what the actual
  # durations are in specific units.  This method is called internally, and
  # does not need to be called by user code.
  def calculate!
    multiples = [MULTIPLES[:years], MULTIPLES[:months], MULTIPLES[:weeks], MULTIPLES[:days], MULTIPLES[:hours], MULTIPLES[:minutes], MULTIPLES[:seconds]]
    units     = []
    @total    = @seconds.to_f.round
    multiples.inject(@total) do |total, multiple|
      # Divide into largest unit
      units << total / multiple
      total % multiple # The remainder will be divided as the next largest
    end

    # Gather the divided units
    @years, @months, @weeks, @days, @hours, @minutes, @seconds = units
  end

  def i18n_for(singular)
    if singular == :total
      fn_name = :total
      singular = :second
      plural = 'seconds'
    elsif singular.to_s.start_with?('total_')
      fn_name = "#{singular}s"
      singular = singular.to_s['total_'.length..-1]
      plural = "#{singular}s"
    else
      plural = "#{singular}s"
      fn_name = plural
    end
    label = send(fn_name) == 1 ? singular : plural

    I18n.t(label, :scope => :ruby_duration, :default => label.to_s)
  end
end