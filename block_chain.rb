class BlockChain
  def initialize
    @blocks = []
    @blocks << BlockChain.get_genesis_block
  end

  def last_block
    @blocks.last
  end

  def next_block(transactions)
    height = last_block.height + 1
    timestamp = Time.now.to_i
    previous_hash = last_block.hash

    pow = ProofOfWork.new(
      timestamp: timestamp,
      previous_hash: previous_hash,
      transactions: transactions
    )
    nonce, hash = pow.do_proof_of_work

    Block.new(
      hash: hash,
      height: height,
      transactions: transactions,
      nonce: nonce,
      previous_hash: previous_hash
    )
  end

  def add_block(new_block)
  end

  def self.get_genesis_block
    Block.create_genesis_block
  end
end

