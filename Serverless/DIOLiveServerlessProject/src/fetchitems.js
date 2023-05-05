"Use Strict"

const AWS = require("aws-sdk")

const fetchitems = async (event) =>{    
    const dynamoDB = new AWS.DynamoDB.DocumentClient();
    
    let items;

    try{
        const results = await dynamoDB.scan({
            TableName: "ItemTableNew"
        }).promise();

        items = results.Items

    } catch(error){
        console.log(error);
    };

    return{
        statusCode:200,
        body:JSON.stringify(items),
    };
}

module.exports={
    handler: fetchitems
}