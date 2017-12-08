//
//  rsa.swift
//  YE
//
//  Created by 侯佳男 on 2017/11/22.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation
import SwiftyRSA

let rsa_private_string = "MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAIjeM5NRSCNVXt1SqnpeBzq3OMnuhJLcYjA4hw4sA/5+lBR9EASKEOUf5T2003OdONAI/pBHZAgKphXVSH0vGGrBA1BG0ssRi8KA5151tcEBWMhy8uXIXPrwj+4SwCUnANPx7HiVDHSSZyljbFc0d7onf92Dx2asoQv0hE9Jq3shAgMBAAECgYBtk6AtIJUlnLKvdQCBqYgWLRxtJuXDAmgl/Qu7f+fOt55sbNgHGlZ+ajPJXF0yIbybaagM8OsYORZRQomfl7XujKiSJcPcTndXRTzdv1CKHJGEPr5s8lRdnS5DYeRqxGTXB5+tiaB9YFDlpDerIxcwris/X6A/3XhHwt0awlQC8QJBAM/wCE6rXNeaPix/1My48vWzZxXT4IufMPogSLG+PnGLdfCSVsg0RwkxHgaW8D6bQGLg6kL4EjbaIruFEVCAcl0CQQCogOAzGll0XL2cr+24HvnOK+lwldyMCNWNembQWAw5lKyUmVgwyYaoddGlxPK/OUqV7vRe/6AdxwCqdyMpI+eVAkEAzPIWHgPERDSgZxevVABOZ2Dlj5v/S14h1cYQIDAUN7FvEygJJNZx1Vt17qTCMdKvSUXJXyxGN44UgaKMCD4xeQJBAIBDSWXc4sbeaT7B8/O5MHGtn04h5PV7LAM7btOckgGqmAutBiJs5GGK/YBvgE/q7kle0QkXD+xatLkNYuhH+lkCQQC+ts4ZuF7k2BQ58NgSwYyGEH0gHzjsFxuLeQwV630CVRnCdzah5/0s+dJYAAQzfYmNlKSXB1dw9o9Tk0Tbqzrf"
let rsa_public_string = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCI3jOTUUgjVV7dUqp6Xgc6tzjJ7oSS3GIwOIcOLAP+fpQUfRAEihDlH+U9tNNznTjQCP6QR2QICqYV1Uh9LxhqwQNQRtLLEYvCgOdedbXBAVjIcvLlyFz68I/uEsAlJwDT8ex4lQx0kmcpY2xXNHe6J3/dg8dmrKEL9IRPSat7IQIDAQAB"

let rsa_public_pem = "yy_rsa_public_key"
let rsa_private_pem = "yy_private_key"


class RSA {
    public class func rsa_pem(message: String) -> String {
        let publicKey = try! PublicKey(pemNamed: rsa_public_pem)
        let clear = try! ClearMessage(string: message, using: .utf8)
        let encrypted = try! clear.encrypted(with: publicKey, padding: .PKCS1)
        
        let data = encrypted.data
        let base64String = encrypted.base64String
        print("data == \(data)")
        print("base64String == \(base64String)")
        
        return base64String
        /*
         // Decrypt with a private key
         let privateKey = try! PrivateKey(pemNamed: rsa_private_pem)
         let encrypted1 = try! EncryptedMessage(base64Encoded: base64String)
         let clear1 = try! encrypted1.decrypted(with: privateKey, padding: .PKCS1)
         
         // Then you can use:
         let data1 = clear1.data
         let base64String1 = clear1.base64String
         let string = try! clear1.string(encoding: .utf8)
         
         print("data1 == \(data1)")
         print("base64String1 == \(base64String1)")
         print("解析之后string == \(string)")
         */
    }
    
    public class func rsa_string(message: String) -> String {
        let publicKey = try! PublicKey(pemEncoded: rsa_public_string)
        let clear = try! ClearMessage(string: message, using: .utf8)
        let encrypted = try! clear.encrypted(with: publicKey, padding: .PKCS1)
        
        // Then you can use:
        let data = encrypted.data
        let base64String = encrypted.base64String
        print("data == \(data)")
        print("base64String == \(base64String)")
        return base64String
        
        /*
        // Decrypt with a private key
        let privateKey = try! PrivateKey(pemEncoded: rsa_private_string)
        let encrypted1 = try! EncryptedMessage(base64Encoded: base64String)
        let clear1 = try! encrypted1.decrypted(with: privateKey, padding: .PKCS1)
        
        // Then you can use:
        let data1 = clear1.data
        let base64String1 = clear1.base64String
        let string = try! clear1.string(encoding: .utf8)
        
        print("data1 == \(data1)")
        print("base64String1 == \(base64String1)")
        print("解析之后string == \(string)")
         */
    }
}

