require 'digest/sha2'
require 'json'

require_relative 'block'

class BlockChain
  attr_reader :blocks

  def initialize
    @blocks = []
    @blocks << BlockChain.genesis_block
  end

  def next_block(transactions)
    height = last_block.height + 1
    timestamp = Time.now.to_i
    previous_hash = last_block.hash

    pow = ProofOfWork.new(timestamp, transactions, previous_hash)
    nonce, hash = pow.execute

    Block.new(hash, height, transactions, timestamp, nonce, previous_hash)
  end

  def size
    @blocks.size
  end

  def add_block(new_block)
    @blocks << new_block if valid_new_block?(new_block)
  end

  def valid_new_block?(new_block)
    return false unless valid_height?(new_block)
    return false unless valid_previous_hash?(new_block)
    return false unless valid_calculate?(new_block)
    true
  end

  def self.genesis_block
    Block.create_genesis_block
  end

  private

  def last_block
    @blocks.last
  end

  def valid_height?(new_block)
    return true if last_block.height + 1 == new_block.height
    puts 'invalid height'
    false
  end

  def valid_previous_hash?(new_block)
    return true if last_block.hash == new_block.previous_hash
    puts 'invalid hash: previous hash'
    false
  end

  def valid_calculate?(new_block)
    return true if calculate_hash_for_block(new_block) == new_block.hash
    puts 'invalid hash: hash'
    puts calculate_hash_for_block(new_block)
    puts new_block.hash
    false
  end

  def calculate_hash_for_block(block)
    Digest::SHA256.hexdigest({
      timestamp: block.timestamp,
      transactions: block.transactions,
      previous_hash: block.previous_hash,
      nonce: block.nonce
    }.to_json)
  end
end
