module TiDao
	class Key
		Seed = (1..9).to_a.join() +
			('a'..'z').to_a.join() +
			('A'..'Z').to_a.join()

		def initialize
			a = []
			32.times do
				a << Seed[rand(1000) % Seed.length]
			end
			@key = a.join
		end

		def to_s
			@key
		end
	end
end

