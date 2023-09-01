
use tokio::fs::File as TokioFile;
use tokio::io::AsyncWriteExt;
use reqwest::Url;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    // URL of the Minecraft server JAR
    let jar_url = Url::parse("https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar")?;

    // Send an HTTP GET request
    let response = reqwest::get(jar_url).await?;

    // Ensure the request was successful (status code 200 OK)
    if !response.status().is_success() {
        return Err("Failed to fetch the server JAR".into());
    }

    // Read the response body and save it to a local file
    let mut jar_file = TokioFile::create("server.jar").await?;
    let bytes = response.bytes().await?;
    jar_file.write_all(&bytes).await?;

    println!("Server JAR downloaded successfully");

    Ok(())
}

