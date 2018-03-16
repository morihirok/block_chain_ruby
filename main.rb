require_relative 'src/block_chain'
require_relative 'src/miner'

receive_block_chain = BlockChain.new

puts 'start'
miner = Miner.new(name: 'Miner')

3.times do
  miner.accept(receive_block_chain)
  miner.add_new_block
  puts "#{miner.name} broadcasted"
  receive_block_chain = miner.block_chain

  receive_block_chain.blocks.each do |block|
    puts "*** Block #{block.height} ***"
    puts "hash: #{block.hash}"
    puts "previous_hash: #{block.previous_hash}"
    puts "timestamp: #{block.timestamp}"
    puts "transactions: #{block.transactions}"
    puts "nonce: #{block.nonce}"
    puts ''
  end
end
