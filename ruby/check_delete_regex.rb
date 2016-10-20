class Rule
  @rules = []
  @warnings = []

  def self.inherited klass
    @rules << klass
  end

  def self.run_rules files
    files.each do |name|
      code = File.read(name)
      @rules.each do |r|
        r.new.run(name, code)
      end
    end
  end

  def self.warnings
    @warnings
  end

  def warn file_name, msg
    Rule.warnings << [file_name, msg]
  end
end

class CheckSurvey < Rule
  def run(file_name, code)
    if code =~ /delete_survey\([^,)]+\)/
      warn file_name, "delete_survey without user ID"
    end
  end
end

system "git checkout #{ARGV[0]}"


files = `git diff --name-status master HEAD | grep -E "^(A|M)" | cut -f 2`

Rule.run_rules(files.split)

Rule.warnings.each do |file_name, message|
  puts "#{message} in #{file_name}"
end

if Rule.warnings.any?
  exit 1
end
