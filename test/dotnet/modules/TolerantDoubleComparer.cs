﻿// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.
// See the LICENSE file in the project root for more information.

using System;
using System.Collections.Generic;

namespace DotnetTests
{
    class TolerantDoubleComparer : IEqualityComparer<double>
    {
        readonly double tolerance;

        public TolerantDoubleComparer(double tolerance)
        {
            this.tolerance = tolerance;
        }

        public static TolerantDoubleComparer FromTolerance(double tolerance) => new TolerantDoubleComparer(tolerance);

        public bool Equals(double x, double y) => Math.Abs(x - y) < tolerance;

        public int GetHashCode(double obj)
        {
            throw new NotImplementedException();
        }
    }
}
