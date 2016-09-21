require 'json'

module XClarityClient
  class CanisterManagement < XClarityBase

    BASE_URI = '/canisters'.freeze

    def initialize(conf)
      super(conf, BASE_URI)
    end

    def population
      response = connection(BASE_URI)

      body = JSON.parse(response.body)
      body.map do |canister|
        Canister.new
      end
    end

    def get_object_canisters(uuids, includeAttributes, excludeAttributes)

      response = if not includeAttributes.nil?
        get_object_canisters_include_attributes(uuids, includeAttributes)
      elsif not excludeAttributes.nil?
        get_object_canisters_exclude_attributes(uuids, excludeAttributes)
      elsif not uuids.nil?
        connection(BASE_URI + "/" + uuids.join(","))
      else
        connection(BASE_URI)
      end

      body = JSON.parse(response.body)
      body.map do |canister|
        Canister.new
      end

    end

    def get_object_canisters_exclude_attributes(uuids, attributes)

      response = if not uuids.nil?
        connection(BASE_URI + "/#{uuids.join(",")}"+"?excludeAttributes=#{attributes.join(",")}")
      else
        connection(BASE_URI + "?excludeAttributes=" + attributes.join(","))
      end

    end

    def get_object_canisters_include_attributes(uuids, attributes)
      response = if not uuids.nil?
                   connection(BASE_URI + "/" + uuids.join(",") + "?includeAttributes=" + attributes.join(","))
                 else
                   connection(BASE_URI + "?includeAttributes=" + attributes.join(","))
                 end
    end
  end
end
