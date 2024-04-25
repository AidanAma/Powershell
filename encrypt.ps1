function TripleDES-EncryptFile {
    param (
        [string]$inputFilePath,
        [string]$outputFilePath,
        [string]$pass
    )

    $key = $pass.PadRight(24, ' ')   # Pad the passphrase to 24 characters
    $TripleDES = New-Object System.Security.Cryptography.TripleDESCryptoServiceProvider
    $TripleDES.Key = [System.Text.Encoding]::UTF8.GetBytes($key)
    $TripleDES.Mode = [System.Security.Cryptography.CipherMode]::ECB

    try {
        $DESEncrypter = $TripleDES.CreateEncryptor()

        # Read the content of the input file
        $inputBytes = [System.IO.File]::ReadAllBytes($inputFilePath)

        # Encrypt the content
        $encryptedBytes = $DESEncrypter.TransformFinalBlock($inputBytes, 0, $inputBytes.Length)

        # Convert the encrypted bytes to Base64 string
        $encryptedBase64 = [System.Convert]::ToBase64String($encryptedBytes)

        # Write the encrypted content to a new file
        Set-Content -Path $outputFilePath -Value $encryptedBase64 -Encoding Byte

        Write-Host "File encrypted successfully."
    } catch {
        Write-Host "Error: $_"
    }
}

# Example usage:
$inputFilePath = "CHANGE ME"
$outputFilePath = "CHANGE ME"
$password = "YourActualPassphraseHere"

TripleDES-EncryptFile -inputFilePath $inputFilePath -outputFilePath $outputFilePath -pass $password
