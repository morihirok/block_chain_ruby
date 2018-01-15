require_relative 'transaction_input'
require_relative 'transaction_output'

class Transaction
  attr_reader :tx_id, :inputs, :outputs

  def initialize(args)
    @inputs = args[:inputs]
    @outputs = args[:outputs]
    @tx_id = args[:tx_id]
  end

  def self.new_coinbase_transaction
  end
end

