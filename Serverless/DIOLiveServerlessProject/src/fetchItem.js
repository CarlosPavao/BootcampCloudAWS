"Use Strict"

const AWS = require("aws-sdk")

const fetchitem = async (event) =>{
    
    const dynamoDB = new AWS.DynamoDB.DocumentClient();
    const {id} = event.pathParameters

    let item;

    try{
        const result = await dynamoDB.get({
            TableName: "ItemTableNew",
            Key:{id}
        }).promise();
        

    } catch(error){
        console.log(error);
    };

    return{
        statusCode:200,
        body:JSON.stringify(item),
    }
}

module.exports={
    handler: fetchitem,
};