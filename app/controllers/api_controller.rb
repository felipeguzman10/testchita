class ApiController < ApplicationController
  def index
  end
  def resultado
    rutemisor = params[:rutemisor]
    rutreceptor = params[:rutreceptor]
    montofactura = params[:montofactura].to_i || 0
    foliofactura = params[:foliofactura].to_i || 0
    fechavencimiento = params[:fechavencimiento]

    url = "https://chita.cl/api/v1/pricing/simple_quote?client_dni=#{rutemisor}&debtor_dni=#{rutreceptor}&document_amount=#{montofactura}&folio=#{foliofactura}&expiration_date=#{fechavencimiento}"
    header = {"X-Api-Key": "UVG5jbLZxqVtsXX4nCJYKwtt"}
    response = RestClient.get(url, headers= header)
    result = JSON.parse response
    tasadenegocio = result['document_rate'] || 0
    comision = result['commission'] || 0
    porcentajeanticipo = result['advance_percent'] || 0

    @costodefinanciamiento = (montofactura * (porcentajeanticipo/100) * ((tasadenegocio/100) / 30 * 31)).round(1)
    @girorecibir =  ((montofactura * (porcentajeanticipo/100)) - (montofactura * (porcentajeanticipo / 100) * ((tasadenegocio/100) / 30 * 31))  - (comision)).round(1)
    @excedentes = (montofactura - (montofactura * (porcentajeanticipo/100))).round(1)

  end
end
