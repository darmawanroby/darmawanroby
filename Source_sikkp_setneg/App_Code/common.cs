///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : common.cs                                   
//        File terkait  : 
//        Deskripsi     : File Rutin Enkripsi
//
// 2. Penulis Program
//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
//
// 3. Tanggal update    : 10/09/2009
//
// 4. Versi             : 2.0.1
//
// 5. Historis revisi
//        Versi 2.0.1   : Penambahan fungsi-fungsi dan pengorganisasian Import
//
///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
using System;
using System.Text;
using System.IO;
using System.Security.Cryptography;

namespace rtwin
{
	public class common
	{
        //fungsi: memanggil fungsi Enkripsi
        public static string EncryptText(string strText)
		{
			return Encrypt(strText, "&%#@?,:*").Replace("+", "~");
		}
			
		//fungsi: memanggil fungsi Dekripsi
		public static string DecryptText(string strText)
		{
			string StrText2 = "";
			if (strText.Length > 0)
			{
				StrText2 = strText.Replace("~", "+");
			}
			return Decrypt(StrText2, "&%#@?,:*");
		}
			
		//fungsi: Enkripsi Text
		private static string Encrypt(string strText, string strEncrKey)
		{
			byte[] byKey = new byte[] {};
			byte[] IV = new byte[] {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
				
			try
			{
				byKey = System.Text.Encoding.UTF8.GetBytes(strEncrKey.Substring(0, 8));
					
				DESCryptoServiceProvider des = new DESCryptoServiceProvider();
				byte[] inputByteArray = Encoding.UTF8.GetBytes(strText);
				MemoryStream ms = new MemoryStream();
				CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(byKey, IV), CryptoStreamMode.Write);
				cs.Write(inputByteArray, 0, inputByteArray.Length);
				cs.FlushFinalBlock();
				return Convert.ToBase64String(ms.ToArray());
			}
			catch (Exception ex)
			{
				return ex.Message;
			}
		}
			
		//fungsi: Dekripsi Text
		private static string Decrypt(string strText, string sDecrKey)
		{
			byte[] byKey = new byte[] {};
			byte[] IV = new byte[] {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
			byte[] inputByteArray = new byte[strText.Length + 1];
				
			try
			{
				byKey = System.Text.Encoding.UTF8.GetBytes(sDecrKey.Substring(0, 8));
				DESCryptoServiceProvider des = new DESCryptoServiceProvider();
				inputByteArray = Convert.FromBase64String(strText);
				MemoryStream ms = new MemoryStream();
				CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(byKey, IV), CryptoStreamMode.Write);
					
				cs.Write(inputByteArray, 0, inputByteArray.Length);
				cs.FlushFinalBlock();
				System.Text.Encoding encoding = System.Text.Encoding.UTF8;
					
				return encoding.GetString(ms.ToArray());
				
			}
			catch (Exception ex)
			{
				return ex.Message;
			}
				
		}
			
        //fungsi: enkripsi password
		public static string cekuser(string password)
		{
			System.Security.Cryptography.MD5CryptoServiceProvider x = new System.Security.Cryptography.MD5CryptoServiceProvider();
			byte[] bs = System.Text.Encoding.UTF8.GetBytes(password);
			bs = x.ComputeHash(bs);
			System.Text.StringBuilder s = new System.Text.StringBuilder();
			foreach (byte b in bs)
			{
				s.Append(b.ToString("x2").ToLower());
			}
			return s.ToString();
		}
			
        //fungsi: generate Password random
		public static string CreateRandomPassword(int PasswordLength)
		{
			string _allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
			Random randNum = new Random();
			char[] chars = new char[PasswordLength+ 1];
			int allowedCharCount = _allowedChars.Length;
			string s = "";
				
			int i;
			for (i = 0; i <= PasswordLength - 1; i += i + 1)
			{
				chars[i] = _allowedChars[System.Convert.ToInt32((_allowedChars.Length - 1) * randNum.NextDouble())];
				s += chars[i];
			}
				
			return s;
		}
	}
		
}
