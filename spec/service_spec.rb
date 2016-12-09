describe "YouMagine" do
  it "throws an exception when the host is down" do
    stub_request(:get, %r{youmagine.com}).to_raise(Errno::EHOSTDOWN)

    expect{ Youmagine::Design.all }.to raise_exception(Youmagine::ConnectionException, "Host is down")
  end
end
