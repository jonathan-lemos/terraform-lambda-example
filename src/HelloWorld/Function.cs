using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Net.Http;
using Newtonsoft.Json;

using Amazon.Lambda.Core;
using Amazon.Lambda.APIGatewayEvents;

// Assembly attribute to enable the Lambda function's JSON input to be converted into a .NET class.
[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.Json.JsonSerializer))]

namespace HelloWorld
{

    public class Function
    {
        public static string HelloResponse(string? input) => $"Hello, {input ?? "world"}";

        public APIGatewayProxyResponse FunctionHandler(APIGatewayProxyRequest? apigProxyEvent, ILambdaContext context)
        {
            var body = apigProxyEvent?.Body;

            return new APIGatewayProxyResponse
            {
                Body = HelloResponse(body),
                StatusCode = 200,
                Headers = new Dictionary<string, string> { { "Content-Type", "text/plain" } }
            };
        }
    }
}
