require 'digest/sha2'
require 'json'

require_relative 'transaction_input'
require_relative 'transaction_output'

class Transaction
  attr_reader :tx_id, :inputs, :outputs

  def initialize(args)
    @inputs = args[:inputs]
    @outputs = args[:outputs]
    @tx_id = args[:tx_id]
  end

  def self.new_coinbase_transaction(to, data)
    subsidy = 50
    data ||= "Reward to #{to}"

    tx_in = [
      Input.new(
        tx_id: nil,
        v_out: -1,
        script_sig: data
      )
    ]

    tx_out = [
      Output.new(
        value: subsidy,
        script_pubkey: to
      )
    ]

    Transaction.new(
      tx_id: calculate_hash_for_tx(tx_in, tx_out),
      inputs: tx_in,
      outputs: tx_out
    )
  end

  def self.calculate_hash_for_tx(tx_in, tx_out)
    Digest::SHA256.hexdigest({
      tx_in: tx_in,
      tx_out: tx_out
    }.to_json)
  end
end
