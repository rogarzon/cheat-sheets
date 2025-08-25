# MCP Architecture

1. **Hosts:** MCP hosts are the physical or virtual machines that run the MCP software. They provide the necessary resources for the MCP to operate, including CPU, memory, and storage.
2. **Clients:** MCP clients are the applications or services that interact with the MCP. They can be web applications, mobile apps, or any other software that needs to communicate with the MCP.
3. **Servers:** MCP servers are the backend components that handle the core functionality of the MCP. They manage data processing, storage, and communication between clients and hosts.
4. **Server Primitives:**
    * **Resources:**
        - Are data sources that provide contextual information to AI applications.
        - Are identified by URIs and support discovery through `resources/list` and retrieval through `resources/read` methods
      ```text
      file://documents/project-spec.md
      database://production/users/schema
      api://weather/current
      ```
    * **Prompts:**
        - Are templates that guide the behavior of AI models.
        - They can include variables that are filled in with specific values at runtime.
        - Prompts support variable substitution and can be discovered via `prompts/list` and retrieved with `prompts/get`
      ```text
      "Summarize the following text: {text}"
      "Translate the following sentence to French: {sentence}"
      "Generate a product description for: {product_name}"
      ```
    * **Tools:**
        - Are executable functions that AI models can invoke to perform specific actions. They represent the "verbs" of the MCP ecosystem.
        - Are defined with JSON Schema for parameter validation and discovered through `tools/list` and executed via `tools/call`
      ```javascript
      server.tool(
        "search_products", 
        {
          query: z.string().describe("Search query for products"),
          category: z.string().optional().describe("Product category filter"),
          max_results: z.number().default(10).describe("Maximum results to return")
        }, 
        async (params) => {
          // Execute search and return structured results
          return await productService.search(params);
        }
      );
      ```

# [Official SDKs](https://github.com/microsoft/mcp-for-beginners/blob/main/03-GettingStarted/README.md#official-sdks)

* [TypeScript SDK](https://github.com/modelcontextprotocol/typescript-sdk) - The official TypeScript implementation
* [Python SDK](https://github.com/modelcontextprotocol/python-sdk) - The official Python implementation

# [Python Example: Building an MCP Server](https://github.com/microsoft/mcp-for-beginners/blob/main/01-CoreConcepts/README.md#python-example-building-an-mcp-server)

```python
#!/usr/bin/env python3
import asyncio
from mcp.server.fastmcp import FastMCP
from mcp.server.transports.stdio import serve_stdio

# Create a FastMCP server
mcp = FastMCP(
    name="Weather MCP Server",
    version="1.0.0"
)


@mcp.tool()
def get_weather(location: str) -> dict:
    """Gets current weather for a location."""
    # This would normally call a weather API
    # Simplified for demonstration
    return {
        "temperature": 72.5,
        "conditions": "Sunny",
        "location": location
    }


# Alternative approach using a class
class WeatherTools:
    @mcp.tool()
    def forecast(self, location: str, days: int = 1) -> dict:
        """Gets weather forecast for a location for the specified number of days."""
        # This would normally call a weather API forecast endpoint
        # Simplified for demonstration
        return {
            "location": location,
            "forecast": [
                {"day": i + 1, "temperature": 70 + i, "conditions": "Partly Cloudy"}
                for i in range(days)
            ]
        }


# Instantiate the class to register its tools
weather_tools = WeatherTools()

# Start the server using stdio transport
if __name__ == "__main__":
    asyncio.run(serve_stdio(mcp))
```

# Getting Started with MCP

## Basic MCP Server Structure

* **Server Configuration:** Setup port, authentication, and other settings
* **Resources:** Data and context made available to LLMs
* **Tools:** Functionality that models can invoke
* **Prompts:** Templates for generating or structuring text

## Testing and Debugging

The MCP Inspector is a visual testing tool that helps you:

* **Discover Server Capabilities:** Automatically detect available resources, tools, and prompts
* **Test Tool Execution:** Try different parameters and see responses in real-time
* **View Server Metadata:** Examine server info, schemas, and configurations

```bash
  npx @modelcontextprotocol/inspector mcp dev server.py
```

## Creating a server

```bash
# Create a virtual env and install dependencies
python -m venv venv
source venv\Scripts\activate
pip install "mcp[cli]"
```

```python
# server.py
from mcp.server.fastmcp import FastMCP

# Create an MCP server
mcp = FastMCP("Demo")


# Add an addition tool
@mcp.tool()
def add(a: int, b: int) -> int:
    """Add two numbers"""
    return a + b


# Add a dynamic greeting resource
@mcp.resource("greeting://{name}")
def get_greeting(name: str) -> str:
    """Get a personalized greeting"""
    return f"Hello, {name}!"


# Main execution block - this is required to run the server
if __name__ == "__main__":
    mcp.run()
```

### Test the server

```bash
  mcp run server.py
```

To use MCP Inspector, use `mcp dev server.py` which automatically launches the Inspector and provides the required proxy session token. If using `mcp run server.py`, you’ll need to manually start the
Inspector and configure the connection.

### Run using the inspector

Python wraps a Node.js tool called inspector. It's possible to call said tool like so:

* mcp dev server.py

However, it doesn't implement all the methods available on the tool so you're recommended to run the Node.js tool directly like below:

```bash
  npx @modelcontextprotocol/inspector mcp run server.py
```

