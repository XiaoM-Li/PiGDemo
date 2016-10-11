-- This code is made available under the Apache License, Version 2.0 (the
-- "License"); you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
-- WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
-- License for the specific language governing permissions and limitations
-- under the License.

daily = load 'NYSE_daily' as (exchange:chararray, symbol:chararray,
			date:chararray, open:float, high:float, low:float,
			close:float, volume:int, adj_close:float);
divs  = load 'NYSE_dividends' as (exchange:chararray, symbol:chararray,
			date:chararray, dividends:float);
grpd  = cogroup daily by (exchange, symbol), divs by (exchange, symbol);
sjnd  = filter grpd by not IsEmpty(divs);
final = foreach sjnd generate flatten(daily);
dump final;
