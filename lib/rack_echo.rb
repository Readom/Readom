class RackEcho
  def initialize(app)
    @app = app
  end

  def call(request)
    status = 200
    headers = {'Content-Type' => 'text/plain'}
    data = NSJSONSerialization.dataWithJSONObject(
        {
          url: request.URL.absoluteString,
          headers: request.allHTTPHeaderFields,
          body: request.HTTPBody
        },
        options:0,
        error:nil
      ).to_str.to_data

    return status, headers, data
  end
end
