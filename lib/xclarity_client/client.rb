module XClarityClient
  class Client

    def initialize(connection)
      @connection = connection
    end

    def discover_nodes
      NodeController.new(@connection).population
    end

    def fetch_nodes(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      array_nodes = NodeController.new(@connection)
      .get_object_nodes(uuids, includeAttributes, excludeAttributes)
    end

    def discover_chassis
      ChassiManagement.new(@connection).population
    end

    def fetch_chassis(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      array_chassis = ChassiManagement.new(@connection)
      .get_object_chassis(uuids, includeAttributes, excludeAttributes)
    end


  end
end
