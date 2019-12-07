class V1::OrdersController < ApplicationController

	def create
		client = Client.where(:id => params[:client_id]).first
		newOrder = Order.new(order_params)
		newOrder.client = client
		newOrder.total = newOrder.subtotal + newOrder.taxes

		if newOrder.save
			render json: {error: false, order: newOrder}
		end
	end

	def getAll
		orders = Order.all

		clients = []

		orders.each do |order|
		  clients.push(order.client)
		end
		render json: {error: false, orders: orders, clients: clients}
	end

	def changeState
		if params[:id].nil? || params[:id].empty?
			render json: {error: true, msg: 'Se requiere el id de la orden'}
			return
		end
		if params[:status].nil? || params[:status].empty?
			render json: {error: true, msg: 'Se requiere el nuevo estado'}
			return
		end

		order = Order.where(:id => params[:id]).first
		
		case params[:status]
		when "preparacion"
			if order.status == "nuevo"
		  		order.status = "preparacion"
		  		if order.save 
		  			render json: {error: false, msg: 'Estado cambiado correctamente'}
		  		end
		  	else
		  		render json: {error: true, msg: 'No puedes cambiar a este estado'}	  	
		  	end
		when "anulado"
			if order.status == "nuevo"
		  		order.status = "anulado"
		  		if order.save 
		  			render json: {error: false, msg: 'Estado cambiado correctamente'}
		  		end
		  	else
		  		render json: {error: true, msg: 'No puedes cambiar a este estado'}	  	
		  	end
		when "terminado"			
			if order.status == "preparacion"
		  		order.status = "terminado"
		  		if order.save 
		  			render json: {error: false, msg: 'Estado cambiado correctamente'}
		  		end
		  	else
		  		render json: {error: true, msg: 'No puedes cambiar a este estado'}	  	
		  	end
		else
			render json: {error: true, msg: 'Estado invalido'}
		end
	end

	private

	def order_params
		params.permit(:branch, :code, :start_preparation, :delivery_time, :delivery_method, :cash_payment, :subtotal, :taxes, :status)
	end
end
