# cef-pdf

`cef-pdf` is a command line utility (with embedded HTTP server as an optional mode) for creating PDF documents from HTML content. It uses Google Chrome browser's [Chromium Embedded Framework (CEF)](https://bitbucket.org/chromiumembedded/cef/overview) library for all it's internal work; loading urls, rendering HTML & CSS pages and PDF printing, therefore, it produces perfect, accurate, excellent quality PDF documents.

### Usage:

    cef-pdf [options] --url=<url>|--file=<path> [output]

    Options:
      --help -h        This help screen.
      --url=<url>      URL to load, may be http, file, data, anything supported by Chromium.
      --file=<path>    File path to load using file:// scheme. May be relative to current directory.
      --stdin          Read content from standard input until EOF (Unix: Ctrl+D, Windows: Ctrl+Z).
      --size=<spec>    Size (format) of the paper: A3, B2.. or custom <width>x<height> in mm.
                       A4 is the default.
      --list-sizes     Show all defined page sizes.
      --landscape      Wheather to print with a landscape page orientation.
                       Default is portrait.
      --margin=<spec>  Paper margins in mm (much like CSS margin but without units)
                       If omitted some default margin is applied.
      --javascript     Enable JavaScript.
      --backgrounds    Print with backgrounds. Default is without.

    Server options:
      --server         Start HTTP server
      --host=<host>    If starting server, specify ip address to bind to.
                       Default is 127.0.0.1
      --port=<port>    Specify server port number. Default is 9288

    Output:
      PDF file name to create. Default is to write binary data to standard output.

### HTTP server usage

Execute `cef-pdf` with `--server` option and visit `localhost:9288` with web browser. Default json response, with status and version number, should indicate the server is up and running on local machine:

    {
        "status": "ok",
        "version": "0.2.0"
    }

To receive a PDF, just make POST request to `localhost:9288/foo.pdf`with some HTML content as the request body. `foo` may be any name you choose, `.pdf` suffix is always required. The response will contain the PDF data, with `application/pdf` as the content type.

In addition to POSTing content inside the request body, special HTTP header `Content-Location` is supported, which should be an URL to some external content. `cef-pdf` will try to grab the content from this URL and use it just like it was the request's body.

### Building

`cef-pdf` should compile without problems with cmake/ninja on Windows (7, x64), Linux (tested on Debian 8.5.0, x64) and Mac OS X (10.11.6) using decent C++11 compiler. In order to build, [CEF build distribution files](http://opensource.spotify.com/cefbuilds/index.html) must be downloaded and placed in some directory, like `/path/to/cef/release` in the example below.

```
$ mkdir ~/build
$ cd ~/build
$ cmake -G "Ninja" -DCMAKE_BUILD_TYPE=Release -DCEF_ROOT=/path/to/cef/release /path/to/cef-pdf
$ ninja
```

### License
`cef-pdf` is licensed under the MIT license.


# Tangro-Adjustments:

I did two small changes:

a)
```
m_settings.command_line_args_disabled = false;
```
This change allows passing command line parameters to the CEF, e.g. : 
```
--proxy-server="proxy.tangro.de:8080"
```
See the following uri for Chrome proxy configuration parameters:
http://www.chromium.org/developers/design-documents/network-settings#TOC-Command-line-options-for-proxy-settings

b) 
```
m_settings.ignore_certificate_errors = true;
```

This settings ignores any certificate error in the future; e.g. if any certificate or even CA validity has expired. the rest is identical to the project cef-pdf (see https://github.com/jcoleman1969/cef-pdf).


### Building with Visual Studio 2017

1. install CMake from https://cmake.org/

2. Download the following version from the chrome embedded framework (or any newer version*):
http://opensource.spotify.com/cefbuilds/cef_binary_73.1.12%2Bgee4b49f%2Bchromium-73.0.3683.75_windows64.tar.bz2

3. unpack the above to a directory cef/ inside the project (see path below, can be changed... you need to set variable DCEF_ROOT to point to the dir)

4. execute the following command **inside the project** to create Win64 solution files for VS2017 (adjust paths)- or give git repo path as second param (instead of .):

```
cmake -G "Visual Studio 15 2017 Win64" -DCMAKE_BUILD_TYPE=Release -DCEF_ROOT=C:/path/to/cef-pdf/cef C:/path/to/cef-pdf/
```
e.g.:
```
cmake -G "Visual Studio 15 2017 Win64" -DCMAKE_BUILD_TYPE=Release -DCEF_ROOT=C:/develop/visual_studio/cef-pdf/cef .
```

*NOTE: some methods might have changed!