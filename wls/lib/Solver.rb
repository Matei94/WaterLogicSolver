#!/usr/bin/ruby1.9.1

class Algorithm

	def initialize(capacities, init_state, aim_glass, aim_volume, fill, empty, half)
		@@solution_string = ""
		@@findWinner = false
		@@solution = []
		@@states = []
		@@bingo = []
		@@current_generation = []

		@@capacities = capacities
		@@initial_state = init_state
		@@aim_glass = aim_glass
		@@aim_volume = aim_volume
		@@fill = fill
		@@empty = empty
		@@half = half

		@@states << @@initial_state
		@@current_generation << @@initial_state
		@@bingo << @@current_generation
	end

	def solve
	#	initialization

		while 1>0
			@@current_generation = get_next_generation

			print @@current_generation

			if (@@findWinner == true) 
				return @@solution_string
			end

			if (@@current_generation.size == 0)
				return "Imposible"
			end
		end
	end


	

	def set_glasses_capacities
		puts "Enter glasses capacities:"
		return gets.chomp.split().collect {|i| i.to_i}
	end

	def set_initial_state
		puts "Enter initial state:"
		initial_state = gets.chomp.split().collect {|i| i.to_i}
		if initial_state.size != @@capacities.size
			puts "Error #1: Must initialize #{@@capacities.size} number of glasses"
			exit
		else
			(0...(@@capacities.size)).each do |i|
				if initial_state[i] > @@capacities[i] || initial_state[i] < 0
					puts "Error #2: Glass #{i+1} not correctly initialized"
					exit
				end
			end
			return initial_state
		end
	end

	def set_aim_glass
		puts "Enter aim glass:"
		aim_glass = gets.chomp.to_i
		if (aim_glass > @@capacities.size || aim_glass < 1)
			puts "Error #3: Wrong aim glass"
			exit
		end
		return aim_glass-1
	end

	def set_aim_volume
		puts "Enter aim volume:"
		aim_volume = gets.chomp.to_i
		if (@@capacities[@@aim_glass] < aim_volume || aim_volume < 0)
			puts "Error #4: Wrong aim volume"
			exit
		end
		return aim_volume
	end

	def get_next_generation
		next_generation = []
		cloned = []
		returned_state = []
		current_generation_size = @@current_generation.size

		l = -1
		k = 0

		@@current_generation.each do |state|
			l += 1

			#Permutations
			if (@@findWinner == false)

				(0...(@@capacities.size)).each do |i|
					(0...(@@capacities.size)).each do |j|

						returned_state = permute(state, i, j)
						unless @@states.include? returned_state
							bingo_size = @@bingo.size
							cloned = @@bingo[l + bingo_size - current_generation_size - k].clone
							cloned << returned_state
							@@bingo << cloned

							isWinner(returned_state)
							next_generation << returned_state
							@@states << returned_state
							k += 1
						end

					end
				end

			end

			#Fill
			if (@@fill == true && @@findWinner == false)
				(0...(@@capacities.size)).each do |i|
					returned_state = fill(state, i)

					unless @@states.include? returned_state
						bingo_size = @@bingo.size
						cloned = @@bingo[l + bingo_size - current_generation_size - k].clone
						cloned << returned_state
						@@bingo << cloned

						isWinner(returned_state)
						next_generation << returned_state
						@@states << returned_state
						k+= 1
					end

				end
			end

			#Empty
			if (@@empty == true && @@findWinner == false)
				(0...(@@capacities.size)).each do |i|
					returned_state = empty(state, i)

					unless @@states.include? returned_state
						bingo_size = @@bingo.size
						cloned = @@bingo[l + bingo_size - current_generation_size - k].clone
						cloned << returned_state
						@@bingo << cloned

						isWinner(returned_state)
						next_generation << returned_state
						@@states << returned_state
						k+= 1
					end

				end
			end

			#Half
			if (@@half == true && @@findWinner == false)
				(0...(@@capacities.size)).each do |i|
					returned_state = half(state, i)

					unless @@states.include? returned_state
						bingo_size = @@bingo.size
						cloned = @@bingo[l + bingo_size - current_generation_size - k].clone
						cloned << returned_state
						@@bingo << cloned

						isWinner(returned_state)
						next_generation << returned_state
						@@states << returned_state
						k+= 1
					end

				end
			end

		end

		return next_generation
	end

	def permute(state, i, j)
		state_copy = state.clone
		
		if (i != j && state_copy[j] != @@capacities[j] && state_copy[i] != 0)

			if (state_copy[i] <= (@@capacities[j] - state_copy[j]))
				state_copy[j] += state_copy[i]
				state_copy[i] = 0
			else
				state_copy[i] -= (@@capacities[j] - state_copy[j])
				state_copy[j] = @@capacities[j]
			end

		end

		return state_copy
	end

	def fill(state, i)
		state_copy = state.clone
		state_copy[i] = @@capacities[i]
		return state_copy
	end

	def empty(state, i)
		state_copy = state.clone
		state_copy[i] = 0
		return state_copy
	end

	def half(state, i)
		state_copy = state.clone
		if (state_copy[i] % 2 == 0)
			state_copy[i] = state_copy[i] / 2
		end
		return state_copy
	end

	def isWinner(state)
		if (state[@@aim_glass] == @@aim_volume)
			@@solution = @@bingo[@@bingo.size - 1]
			@@findWinner = true
			get_solution_string
		end
	end

	def get_solution_string
		max = @@solution.max.max.to_s.size

		@@solution.each do |state|
			state.each do |i|
				@@solution_string += i.to_s
				(max-i.to_s.size+5).times do
					@@solution_string += " "
				end
			end

			while 1>0
				if @@solution_string[-1] == " "
					@@solution_string.chop!
				else
					break;
				end
			end

		#	@@solution_string += state.to_s
			@@solution_string += ","
		end
	end

end
