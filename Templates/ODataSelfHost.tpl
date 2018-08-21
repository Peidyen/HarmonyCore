<CODEGEN_FILENAME>SelfHost.dbl</CODEGEN_FILENAME>
<REQUIRES_CODEGEN_VERSION>5.3.5</REQUIRES_CODEGEN_VERSION>
<REQUIRES_USERTOKEN>SERVICES_NAMESPACE</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>SERVER_HTTP_PORT</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>SERVER_HTTPS_PORT</REQUIRES_USERTOKEN>
;//****************************************************************************
;//
;// Title:       ODataSelfHost.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Generates a program to self-host Harmony Core services
;//
;// Copyright (c) 2018, Synergex International, Inc. All rights reserved.
;//
;// Redistribution and use in source and binary forms, with or without
;// modification, are permitted provided that the following conditions are met:
;//
;// * Redistributions of source code must retain the above copyright notice,
;//   this list of conditions and the following disclaimer.
;//
;// * Redistributions in binary form must reproduce the above copyright notice,
;//   this list of conditions and the following disclaimer in the documentation
;//   and/or other materials provided with the distribution.
;//
;// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
;// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;// POSSIBILITY OF SUCH DAMAGE.
;//
;;*****************************************************************************
;;
;; Title:       SelfHost.dbl
;;
;; Type:        Class
;;
;; Description: A program to self-host Harmony Core services
;;
;;*****************************************************************************
;; WARNING
;;
;; This file was code generated. Avoid editing this file, as any changes that
;; you make will be lost of the file is re-generated.
;;
;;*****************************************************************************
;;
;; Copyright (c) 2018, Synergex International, Inc.
;; All rights reserved.
;;
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions are met:
;;
;; * Redistributions of source code must retain the above copyright notice,
;;   this list of conditions and the following disclaimer.
;;
;; * Redistributions in binary form must reproduce the above copyright notice,
;;   this list of conditions and the following disclaimer in the documentation
;;   and/or other materials provided with the distribution.
;;
;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;; ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
;; LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;; CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;; POSSIBILITY OF SUCH DAMAGE.
;;
;;*****************************************************************************

import Microsoft.AspNetCore
import Microsoft.AspNetCore.Hosting
import Microsoft.AspNetCore.TestHost
import System.IO
import <SERVICES_NAMESPACE>
import <NAMESPACE>

main SelfHost

proc
	;;Configure the environment
	UnitTestEnvironment.AssemblyInitialize(^null)

	;Leave this here for Jeff 
	;data tester = new OrderTests()  
	;tester.GetOrders_Expand_REL_TagCustomer() 
	;tester.GetOrders_Expand_REL_TagVendor()
	;tester.GetOrders_Expand_All()
	;tester.GetCustomer()      

	Console.WriteLine("API documentation is available at /api-docs")

	;;Start self-hosting (Kestrel)
	data wwwroot = Path.Combine(AppContext.BaseDirectory, "wwwroot")

	WebHost.CreateDefaultBuilder(new string[0])
	&	.UseContentRoot(wwwroot)
	&	.UseWebRoot(wwwroot)
<IF DEFINED_IIS_SUPPORT>
	&	.UseIISIntegration()
</IF DEFINED_IIS_SUPPORT>
	&	.UseStartup<Startup>()
	&	.UseUrls("http://localhost:<SERVER_HTTP_PORT>", "https://localhost:<SERVER_HTTPS_PORT>")
	&	.Build()
	&	.Run()

	;;Cleanup the environment
	UnitTestEnvironment.AssemblyCleanup()

endmain