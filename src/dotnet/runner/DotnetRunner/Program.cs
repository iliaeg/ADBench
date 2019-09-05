﻿using System;

namespace DotnetRunner
{
    class Program
    {
        static int Main(string[] args)
        {
            try
            {
                if (args.Length < 8)
                {
                    Console.Error.WriteLine("usage: DotnetRunner testType modulePath inputFilepath outputDir minimumMeasurableTime nrunsF nrunsJ timeLimit [-rep]");
                    return 1;
                }

                var testType = args[0].ToUpperInvariant();
                var modulePath = args[1];
                var inputFilePath = args[2];
                var outputPrefix = args[3];
                var minimumMeasurableTime = TimeSpan.FromMilliseconds(double.Parse(args[4]));
                var nrunsF = int.Parse(args[5]);
                var nrunsJ = int.Parse(args[6]);
                var timeLimit = TimeSpan.FromMilliseconds(double.Parse(args[7]));

                // read only 1 point and replicate it?
                var replicate_point = (args.Length > 8 && args[8] == "-rep");

                if (testType == "GMM")
                {

                    Benchmark.Run<GMMInput, GMMOutput, GMMParameters>(modulePath, inputFilePath, outputPrefix, minimumMeasurableTime, nrunsF, nrunsJ, timeLimit, new GMMParameters() { });
                }
                else
                {
                    throw new Exception("C++ runner doesn't support tests of " + testType + " type");
                }
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine("An exception caught: " + ex.ToString());
            }
            return 0;
        }
    }

    internal class GMMParameters
    {
    }

    internal class GMMOutput
    {
    }

    internal class GMMInput
    {
    }
}
