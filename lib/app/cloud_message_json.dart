import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

class FirebaseCloudMessaging {
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      //service data
      "type": "service_account",
      "project_id": "helperhive-vishnu",
      "private_key_id": "96f1b839680dd41c0d31f638814d2bcb2d984bd5",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDh5GOtXbBNkrd6\n/khD4iro5eE6UJdPgmfj1CkkGthXeJstH/XFm5xokPnCJBan26q76R9ksMCAsB2V\nSmLCPj7wo4DMBFDxEDbATLYdE3yRaWWHso8jUf7BZbwVq7zzz37wWV6vYjlgcYQR\nw0EUd6d0u0rPaR6Va1RnWWI5sNgabYsU8PVMzQ/gOMyDcjoyFxabboBpwlxT1pjX\n0hcqMWPLqyzdcdfXp6+wOMhnlhdwyb4L7ItZQPTFbadxITz8v+jl34yuGum/iWoz\nVStM9iv3hIIR+j3k0ycpfuYvRXsl4CyE02o19v6eb9x6xQQMdD/0YpHqivM1wRSc\nrWOsCiyBAgMBAAECgf8zwATt5LbNLr2GGdcoZhn6fR+aInhnqLJwSVybfuLtNx4l\nulqtyLaOZhgx196w2exFXGTqxmtzj+VXHFF/uo7kxjBtjNeWQmaoq2pVQu+YyJKQ\nAeI070XzvIDYXh3NpU2pdm/wsgn/BEKDZz3zmG3umjHLToPJK2uMubd9C/yWIPA0\nNBSuBes2Oj1LxK8O+POvAvYtoJ0HSOyECRdKQ9xo6WTj5r+iMCiyInirnlTq/l3C\nLvLTCiKwhpoRxGP4DsNdx86sJL6O4mkcZutWdXtE2QaJGm1r0UukoMHEJf+LTO/h\nUdQfeoPfhTZKYqvmhHZucs4QEvRJqzg0rE/hRwECgYEA9c6dGyDpc2YWiJA+2Pvt\n2+TOzeJp+eAvhY6U5Iqx5Mkc9cruA/UjxK4slJot3UEYZDoe9qU/SvgeuEICmBnC\nNMZmfwOcVpYRXfkwEPrkZu8NP7tVeBqlqKTWUXThkTL95V+FsfIxVhEA2nbaufPt\nhM4sxu2/qsogUsy+ChwddwECgYEA60Jd7mRRH8yrOaa2HF3SKDJmukJ7FrbMn97H\n5mrKpPOoEUQJV869bqKCayXH+aTGg9t5z3XStctgaxGLvUL5aqi2Hxe7Q3kdEKV+\n9vfJ7CRSXy+mMikAdI/WRTAc2gBPyrR3eDMnXspSBlphVToKuMfdQbbELwERtBI4\nLmWONYECgYEA3/O1FAhyah9zHE0/1XYDCrt26AIHSBBHe8miQm9TEP1jE1YmcRih\n1ApUt7eZXeJ3FKoXl+SKvAVAB+SsdGPTmz3AGKzzfbgQbqwgbPgJrPbT/WLyxhCR\nKgu08FYrRZ1N0fOr3aqp5J5tRp3PPmjN2Jf4F+55GGQ7+vRrmM5w0gECgYEAspag\n45U3mCIwYQVS/VmjbWxFW2OYOPfvgfUGXr32sx1cGi9BwGxqlQ+8XUZC9hnFsNbt\nMzXIDMUknmKlZ7jtya/lANltCJ1qGPbo2OXlXON9vFBZo35IoDOIfuE1JbBS4hf5\nEUATxPtlJPl7Jc130im2pmntp5jyLXYfO+lP+QECgYA3JDgKXwhWChUkAK0xhUX8\nGxondReOQKaHO4xYPl4W7lzoiwL4SpEXZyQwAwjNl16mbZ4NOKizE5ne2/T5koMl\n92G5UvDmOqqz715OsWeU3OD2cHUWNrV5bilLcE9b6JbunxvGEWWbazp1zz/+6s+h\nSbpjIeACl9kFKloaxTW5Dw==\n-----END PRIVATE KEY-----\n",
      "client_email":
          "helperhive-cloud-messaging@helperhive-vishnu.iam.gserviceaccount.com",
      "client_id": "106579006049348489434",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/helperhive-cloud-messaging%40helperhive-vishnu.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];
    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    // Obtain the access token
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);

    // Close the HTTP client
    client.close();

    // Return the access token
    return credentials.accessToken.data;
  }
}
