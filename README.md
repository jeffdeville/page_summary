# page_summary
[![Build Status](https://secure.travis-ci.org/jeffdeville/page_summary.png)](http://travis-ci.org/jeffdeville/page_summary)
page_summary is designed to create summaries of pages the way Facebook does, when you copy a link into a status update.

## Usage
PageSummary is an EventMachine component that communicates via websockets. You just pass in an url, and then receive the replies
Page summary is a rails engine, that by default is mounted at: /page_summary.  You create a new page summary by posting to /page_summary (a create call) with the URL you wish to summarize.  That page 
