class V1::ClientsController < ApplicationController
	has_many :orders

	def getAll
		clients = Client.all
		render json: {error: false, clients: clients}
	end

	def create
		newClient = Client.new(client_params)

		if newClient.save
			render json: {error: false, client: newClient}
		end
	end

	private

	def client_params
		params.permit(:name, :lastname, :number_document, :phone, :address)
	end
end
