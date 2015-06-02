class Seeder
  def initialize seed_file
    @seed_file = seed_file
  end

  def load_seed
    unless File.file? @seed_file
      raise "Seed file '#{@seed_file}' does not exist"
    end
    load @seed_file
  end
end
