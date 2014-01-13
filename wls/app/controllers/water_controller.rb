require 'Solver'

class WaterController < ApplicationController
	def formular

	end

	def rezultat
		capacities = []
		capacities << params[:bucket1_cap].to_i if (params[:bucket1_cap] != "")
		capacities << params[:bucket2_cap].to_i if (params[:bucket2_cap] != "") 
		capacities << params[:bucket3_cap].to_i if (params[:bucket3_cap] != "") 
		capacities << params[:bucket4_cap].to_i if (params[:bucket4_cap] != "") 
		capacities << params[:bucket5_cap].to_i if (params[:bucket5_cap] != "")

		init_state = []
		init_state << params[:bucket1_init].to_i if (params[:bucket1_init] != "")
		init_state << params[:bucket2_init].to_i if (params[:bucket2_init] != "")
		init_state << params[:bucket3_init].to_i if (params[:bucket3_init] != "")
		init_state << params[:bucket4_init].to_i if (params[:bucket4_init] != "")
		init_state << params[:bucket5_init].to_i if (params[:bucket5_init] != "")

		aim_glass = params[:aim_glass].to_i - 1
		aim_volume = params[:aim_volume].to_i

		fill = params[:cb_fill] != nil ? true : false
		empty = params[:cb_empty] != nil ? true : false
		half = params[:cb_half] != nil ? true : false

		alg = Algorithm.new(capacities, init_state, aim_glass, aim_volume, fill, empty, half)
		@rex = alg.solve
	end
end
