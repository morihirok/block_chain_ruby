class Input
  attr_reader :tx_id, :v_out, :script_sig

  def initialize(args)
    @tx_id = args[:tx_id]
    @v_out = args[:v_out]
    @script_sig = args[:script_sig]
  end
end
