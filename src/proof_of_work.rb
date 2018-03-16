require 'digest/sha2'
require 'json'
require 'pry'

class ProofOfWork
  attr_reader :timestamp, :transactions, :previous_hash

  def initialize(timestamp, transactions, previous_hash)
    @timestamp = timestamp
    @transactions = transactions
    @previous_hash = previous_hash
  end

  def calc_hash_with_nonce(nonce = 0)
    Digest::SHA256.hexdigest({
      timestamp: @timestamp,
      transactions: @transactions,
      previous_hash: @previous_hash,
      nonce: nonce
    }.to_json)
  end

  def execute(difficulty = '0000')
    nonce = 0

    loop do
      hash = calc_hash_with_nonce(nonce)
      return [nonce, hash] if hash.start_with?(difficulty)
      nonce += 1
    end
  end
end
