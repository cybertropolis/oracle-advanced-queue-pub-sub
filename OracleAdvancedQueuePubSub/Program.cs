using Oracle.DataAccess.Client;
using System;
using System.Text;

namespace OracleAdvancedQueuePubSub
{
    class Program
    {
        static void Main(string[] args)
        {
            // Create connection
            string constr = "user id=scott;password=Pwd4Sct;data source=oracle";
            OracleConnection con = new OracleConnection(constr);

            // Create queue
            OracleAQQueue queue = new OracleAQQueue("scott.test_q", con);

            try
            {
                // Open connection
                con.Open();

                // Begin txn for enqueue
                OracleTransaction txn = con.BeginTransaction();

                // Set message type for the queue
                queue.MessageType = OracleAQMessageType.Raw;

                // Prepare message and RAW payload
                OracleAQMessage enqMsg = new OracleAQMessage();
                byte[] bytePayload = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
                enqMsg.Payload = bytePayload;

                // Prepare to Enqueue
                queue.EnqueueOptions.Visibility = OracleAQVisibilityMode.OnCommit;

                // Enqueue message
                queue.Enqueue(enqMsg);

                Console.WriteLine("Enqueued Message Payload      : "
                  + ByteArrayToString(enqMsg.Payload as byte[]));
                Console.WriteLine("MessageId of Enqueued Message : "
                  + ByteArrayToString(enqMsg.MessageId));

                // Enqueue txn commit
                txn.Commit();

                // Begin txn for Dequeue
                txn = con.BeginTransaction();

                // Prepare to Dequeue
                queue.DequeueOptions.Visibility = OracleAQVisibilityMode.OnCommit;
                queue.DequeueOptions.Wait = 10;

                // Dequeue message
                OracleAQMessage deqMsg = queue.Dequeue();

                Console.WriteLine("Dequeued Message Payload      : "
                  + ByteArrayToString(deqMsg.Payload as byte[]));
                Console.WriteLine("MessageId of Dequeued Message : "
                  + ByteArrayToString(deqMsg.MessageId));

                // Dequeue txn commit
                txn.Commit();
            }
            catch (Exception e)
            {
                Console.WriteLine("Error: {0}", e.Message);
            }
            finally
            {
                // Close/Dispose objects
                queue.Dispose();
                con.Close();
                con.Dispose();
            }
        }

        // Function to convert byte[] to string
        static private string ByteArrayToString(byte[] byteArray)
        {
            StringBuilder sb = new StringBuilder();
            for (int n = 0; n < byteArray.Length; n++)
            {
                sb.Append((int.Parse(byteArray[n].ToString())).ToString("X"));
            }
            return sb.ToString();
        }
    }
}
