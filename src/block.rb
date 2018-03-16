require 'time'

require_relative 'transaction'
require_relative 'proof_of_work'

class Block
  attr_reader :hash, :height, :transactions, :timestamp, :nonce, :previous_hash

  def initialize(*args)
    @hash = args[0]
    @height = args[1]
    @transactions = args[2]
    @timestamp = args[3]
    @nonce = args[4]
    @previous_hash = args[5]
  end

  def self.create_genesis_block
    timestamp = Time.parse('2009/1/3').to_i
    transactions = [Transaction.new_coinbase_transaction(
      '62e907b15cbf27d5425399ebf6f0fb50ebb88f18',
      'The Times 03/Jan/2009 Chancellor on brink of second bailout for banks'
    )]

    nonce, hash = ProofOfWork.new(
      timestamp, '0', transactions
    ).execute
    Block.new(hash, 0, transactions, timestamp, nonce, '0')
  end
end
