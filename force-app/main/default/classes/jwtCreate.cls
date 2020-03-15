public class jwtCreate {

    public static String get_access_token(String serviceAccount_Id){
    
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setEndpoint('https://accounts.google.com/o/oauth2/token');
        req.setMethod('POST');
        req.setHeader('ContentType','application/x-www-form-urlencoded');
        
        String header = '{"alg":"RS256","typ":"JWT"}';
        String header_encoded = EncodingUtil.base64Encode(blob.valueof(header));
        
        //String claim_set = '{"iss":"drpredictov1@rare-shadow-149503.iam.gserviceaccount.com"';
        String claim_set = '{"iss":"' + serviceAccount_Id +'"';
        claim_set += ',"scope":"https://www.googleapis.com/auth/devstorage.read_only https://www.googleapis.com/auth/prediction"';
        claim_set += ',"aud":"https://accounts.google.com/o/oauth2/token"';
        claim_set += ',"exp":"' + datetime.now().addHours(1).getTime()/1000;
        claim_set += '","iat":"' + datetime.now().getTime()/1000 + '"}';
        
        String claim_set_encoded = EncodingUtil.base64Encode(blob.valueof(claim_set));
        
        String signature_encoded = header_encoded + '.' + claim_set_encoded;
        
        String key = 'MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDG8KGnrixyTmQD\n1MlZNCkM+2l99tNPUqhhCKdCxPK2c0D8Uw95RVtuwI+vO/11yfvuffvekB6c6K3b\nf3ufPlOWkCsBsZ0M1nV8Y2hj47vzRlKloByarOipIzei7WIRpe1d+T8RMHjLJ6Vy\nBWFp3r6+GF8gHA7eSS9oHmr9gwAb9ReqMXan67A0V1YUw2ZT2blgGmtHi6Nsbvay\nMiVbeR1xX+/QC2WchxM35zB0c1tmsmOB4Nv3GU16KIeNFqESDoyTR3BLraicLAS9\n/EnaSTd6dD69kRGeJqbKGejzhFTkqG5X3gOPP1nA5CTa3DK6CntdKUky8R0IhcIQ\n5R5lV7T5AgMBAAECggEAeJlNVio3FYBCDzSCbwo4zH7of40OomqYWmJ1ivt7q3EI\n9y2fFsQd3nDraa5zQ2GT0QsckdpKRJKlOof4uBt/bqms+JTkgPDNPf/BO7TFrn92\nAKOkU3v4evg3dRR0vAAbejlrqw74WyeImyt510VJ2lFJ8VwxAz3YeETgVRiCC2+h\n3nN5M9NLrAczacoHMGRIOPPjTZwGJBJ1qr/W95Np6Jg0zY+4yKy1MBvqFdSdFw16\nfnPD7iHcoIVTX96ERgqipoQ6xcW1GCdlk7r9R+ht3O5ILoPf7w1EztoRW0eSTlvp\n1yIFp2bHFPIjzaX66KWDbItY6yrdJO1uoGfDb8GaAQKBgQDs4Mrz8xCrsLNYjp6a\nRhAtg/G1ObtVWQHNFzVKYspEi3z8GagBHrasW6BXPwLxzXtUqKOX6duo4/YxbilS\nidi94vEmN10QzMGs/zGM6YCEX54YUKibDZv5CL4Qeq6C+StmL4VIQ2d/6U1CZ2GG\n+R9SFr/64UYqoOB/njnVoG2cOQKBgQDW/9Ppxvpz+XhYN/DQ9hJUdLfjNTiSRmEE\nldRb2tBvVoVZUUiubgsUIAZSCQ6hamRNRMuPAUa5PHTFa7rH+NiLPFOF7zjXsYoZ\nTIrSx120RncwcK8FgTRanlT0u01QVqHRQeI6TEj1syl3arlBKkAU605UbkQfm8O6\nYNfp/hhewQKBgAHZv7woKfktaDlI4/RQl8/DOCAyU0RXbawsgj4Sh4IBlPhjOuzH\nUKYIETidRWieMlh2+NA3A4BOR54bPjdm3Eqfe0LRK+j1sI2pcLmpGVfvZ0zJVIfh\nk1Zeux1l1/ct+yjRNjlaTXSyXegm5pwnVhdOFjHfkKzElPxqQAlrN3ABAoGAf9I6\n98q/jgGsJa6kcmdJgIKf7OnwRy6mcWZuiWmu7/KddvuXXXS5C276sv0FgLvTBAk5\niDy3AlvKBLFGq6rreuQTuBYAUmQP+XiDNEspD4uxQtBLjddB+/oUAif1ECVhMRqd\nWBGQctrgdUmy9+YZkRZQTGv9/ljJ5d27oDbb4EECgYEApgS27bAtK95K/gf1drKK\nCx47Ka8QFIlnb00M0ATCHavIOK29MjkcgXIyOc6rotKCow1YaUOa0WfwfQQfSY6p\nsCENv6DgCHk+IAbQTXY9x1TTi+PUpFP6D6HLMHMxRCDtO8oVp9evRPgh39LdsWD0\n7QRSVOA+Kax6iUNIJtVTNyI=';
        
        blob private_key = EncodingUtil.base64Decode(key);
        signature_encoded = signature_encoded.replaceAll('=','');
        String signature_encoded_url = EncodingUtil.urlEncode(signature_encoded,'UTF-8');
        blob signature_blob =   blob.valueof(signature_encoded_url);
        
        String signature_blob_string = EncodingUtil.base64Encode(Crypto.sign('RSA-SHA256', signature_blob, private_key));
        
        String JWT = signature_encoded + '.' + signature_blob_string;
        
        JWT = JWT.replaceAll('=','');
        
        String grant_string= 'urn:ietf:params:oauth:grant-type:jwt-bearer';
        req.setBody('grant_type=' + EncodingUtil.urlEncode(grant_string, 'UTF-8') + '&assertion=' + EncodingUtil.urlEncode(JWT, 'UTF-8'));
        res = h.send(req);
        String response_debug = res.getBody() +' '+ res.getStatusCode();
        System.debug('Response =' + response_debug );
        
        if(res.getStatusCode() == 200) {
            JSONParser parser = JSON.createParser(res.getBody());
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'access_token')) {
                    // Move to the value.
                    parser.nextToken();
                    // Return the access_token
                    return parser.getText();
                }
            }
        }
        return 'error';
    
    }

}