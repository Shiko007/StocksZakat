//
//  CurrencyExchange.swift
//  StocksZakat
//
//  Created by Sherif Yasser on 24.04.21.
//

import Foundation


class CurrencyExchange{
    enum NetworkError: Error {
        case badURL , requestFailed , unknown
    }
    
    func getCurrencyExchangeRates(currency : String, completion: @escaping (Result<currencies,NetworkError>) -> Void){
        guard let apiURL = URL(string: StocksConfiguration().currencyExchangeRateAPIPrefix + currency + StocksConfiguration().currencyExchangeRateAPISuffix) else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: apiURL){ data , response , error in
            DispatchQueue.main.async {
                if let data = data{
                    completion(.success(JSONParser().currencyExchangeRate(data: data)!))
                } else if error != nil{
                    completion(.failure(.requestFailed))
                }
                else {
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
    
    func getCurrencyConversionRate(currenciesTable : currencies, fromCurrency: String) -> Double{
        var conversionRate : Double = 1.0
        switch fromCurrency {
        case "usd":
            conversionRate = (currenciesTable.usd?.rate) ?? 1
        case "eur":
            conversionRate = (currenciesTable.eur?.rate) ?? 1
        case "gbp":
            conversionRate = (currenciesTable.gbp?.rate) ?? 1
        case "jpy":
            conversionRate = (currenciesTable.jpy?.rate) ?? 1
        case "chf":
            conversionRate = (currenciesTable.chf?.rate) ?? 1
        case "aud":
            conversionRate = (currenciesTable.aud?.rate) ?? 1
        case "cad":
            conversionRate = (currenciesTable.cad?.rate) ?? 1
        case "nad":
            conversionRate = (currenciesTable.nad?.rate) ?? 1
        case "syp":
            conversionRate = (currenciesTable.syp?.rate) ?? 1
        case "mru":
            conversionRate = (currenciesTable.mru?.rate) ?? 1
        case "wst":
            conversionRate = (currenciesTable.wst?.rate) ?? 1
        case "mur":
            conversionRate = (currenciesTable.mur?.rate) ?? 1
        case "isk":
            conversionRate = (currenciesTable.isk?.rate) ?? 1
        case "pkr":
            conversionRate = (currenciesTable.pkr?.rate) ?? 1
        case "kgs":
            conversionRate = (currenciesTable.kgs?.rate) ?? 1
        case "nio":
            conversionRate = (currenciesTable.nio?.rate) ?? 1
        case "pab":
            conversionRate = (currenciesTable.pab?.rate) ?? 1
        case "xcd":
            conversionRate = (currenciesTable.xcd?.rate) ?? 1
        case "ang":
            conversionRate = (currenciesTable.ang?.rate) ?? 1
        case "dop":
            conversionRate = (currenciesTable.dop?.rate) ?? 1
        case "bam":
            conversionRate = (currenciesTable.bam?.rate) ?? 1
        case "dzd":
            conversionRate = (currenciesTable.dzd?.rate) ?? 1
        case "pln":
            conversionRate = (currenciesTable.pln?.rate) ?? 1
        case "brl":
            conversionRate = (currenciesTable.brl?.rate) ?? 1
        case "gip":
            conversionRate = (currenciesTable.gip?.rate) ?? 1
        case "tmt":
            conversionRate = (currenciesTable.tmt?.rate) ?? 1
        case "svc":
            conversionRate = (currenciesTable.svc?.rate) ?? 1
        case "awg":
            conversionRate = (currenciesTable.awg?.rate) ?? 1
        case "zmw":
            conversionRate = (currenciesTable.zmw?.rate) ?? 1
        case "yer":
            conversionRate = (currenciesTable.yer?.rate) ?? 1
        case "bnd":
            conversionRate = (currenciesTable.bnd?.rate) ?? 1
        case "sgd":
            conversionRate = (currenciesTable.sgd?.rate) ?? 1
        case "ils":
            conversionRate = (currenciesTable.ils?.rate) ?? 1
        case "tnd":
            conversionRate = (currenciesTable.tnd?.rate) ?? 1
        case "irr":
            conversionRate = (currenciesTable.irr?.rate) ?? 1
        case "stn":
            conversionRate = (currenciesTable.stn?.rate) ?? 1
        case "djf":
            conversionRate = (currenciesTable.djf?.rate) ?? 1
        case "all":
            conversionRate = (currenciesTable.all?.rate) ?? 1
        case "mvr":
            conversionRate = (currenciesTable.mvr?.rate) ?? 1
        case "cop":
            conversionRate = (currenciesTable.cop?.rate) ?? 1
        case "xaf":
            conversionRate = (currenciesTable.xaf?.rate) ?? 1
        case "omr":
            conversionRate = (currenciesTable.omr?.rate) ?? 1
        case "rsd":
            conversionRate = (currenciesTable.rsd?.rate) ?? 1
        case "fjd":
            conversionRate = (currenciesTable.fjd?.rate) ?? 1
        case "cdf":
            conversionRate = (currenciesTable.cdf?.rate) ?? 1
        case "szl":
            conversionRate = (currenciesTable.szl?.rate) ?? 1
        case "kes":
            conversionRate = (currenciesTable.kes?.rate) ?? 1
        case "inr":
            conversionRate = (currenciesTable.inr?.rate) ?? 1
        case "bbd":
            conversionRate = (currenciesTable.bbd?.rate) ?? 1
        case "vnd":
            conversionRate = (currenciesTable.vnd?.rate) ?? 1
        case "mad":
            conversionRate = (currenciesTable.mad?.rate) ?? 1
        case "pyg":
            conversionRate = (currenciesTable.pyg?.rate) ?? 1
        case "lrd":
            conversionRate = (currenciesTable.lrd?.rate) ?? 1
        case "sdg":
            conversionRate = (currenciesTable.sdg?.rate) ?? 1
        case "ern":
            conversionRate = (currenciesTable.ern?.rate) ?? 1
        case "ugx":
            conversionRate = (currenciesTable.ugx?.rate) ?? 1
        case "myr":
            conversionRate = (currenciesTable.myr?.rate) ?? 1
        case "ron":
            conversionRate = (currenciesTable.ron?.rate) ?? 1
        case "pen":
            conversionRate = (currenciesTable.pen?.rate) ?? 1
        case "kzt":
            conversionRate = (currenciesTable.kzt?.rate) ?? 1
        case "crc":
            conversionRate = (currenciesTable.crc?.rate) ?? 1
        case "ttd":
            conversionRate = (currenciesTable.ttd?.rate) ?? 1
        case "htg":
            conversionRate = (currenciesTable.htg?.rate) ?? 1
        case "mop":
            conversionRate = (currenciesTable.mop?.rate) ?? 1
        case "vuv":
            conversionRate = (currenciesTable.vuv?.rate) ?? 1
        case "nok":
            conversionRate = (currenciesTable.nok?.rate) ?? 1
        case "TRY":
            conversionRate = (currenciesTable.TRY?.rate) ?? 1
        case "bdt":
            conversionRate = (currenciesTable.bdt?.rate) ?? 1
        case "tjs":
            conversionRate = (currenciesTable.tjs?.rate) ?? 1
        case "mga":
            conversionRate = (currenciesTable.mga?.rate) ?? 1
        case "ves":
            conversionRate = (currenciesTable.ves?.rate) ?? 1
        case "cve":
            conversionRate = (currenciesTable.cve?.rate) ?? 1
        case "mwk":
            conversionRate = (currenciesTable.mwk?.rate) ?? 1
        case "gtq":
            conversionRate = (currenciesTable.gtq?.rate) ?? 1
        case "bwp":
            conversionRate = (currenciesTable.bwp?.rate) ?? 1
        case "rub":
            conversionRate = (currenciesTable.rub?.rate) ?? 1
        case "idr":
            conversionRate = (currenciesTable.idr?.rate) ?? 1
        case "bhd":
            conversionRate = (currenciesTable.bhd?.rate) ?? 1
        case "uah":
            conversionRate = (currenciesTable.uah?.rate) ?? 1
        case "mkd":
            conversionRate = (currenciesTable.mkd?.rate) ?? 1
        case "xpf":
            conversionRate = (currenciesTable.xpf?.rate) ?? 1
        case "mmk":
            conversionRate = (currenciesTable.mmk?.rate) ?? 1
        case "lkr":
            conversionRate = (currenciesTable.lkr?.rate) ?? 1
        case "clp":
            conversionRate = (currenciesTable.clp?.rate) ?? 1
        case "sek":
            conversionRate = (currenciesTable.sek?.rate) ?? 1
        case "php":
            conversionRate = (currenciesTable.php?.rate) ?? 1
        case "mro":
            conversionRate = (currenciesTable.mro?.rate) ?? 1
        case "lbp":
            conversionRate = (currenciesTable.lbp?.rate) ?? 1
        case "bzd":
            conversionRate = (currenciesTable.bzd?.rate) ?? 1
        case "kmf":
            conversionRate = (currenciesTable.kmf?.rate) ?? 1
        case "sll":
            conversionRate = (currenciesTable.sll?.rate) ?? 1
        case "scr":
            conversionRate = (currenciesTable.scr?.rate) ?? 1
        case "dkk":
            conversionRate = (currenciesTable.dkk?.rate) ?? 1
        case "aed":
            conversionRate = (currenciesTable.aed?.rate) ?? 1
        case "twd":
            conversionRate = (currenciesTable.twd?.rate) ?? 1
        case "jod":
            conversionRate = (currenciesTable.jod?.rate) ?? 1
        case "ars":
            conversionRate = (currenciesTable.ars?.rate) ?? 1
        case "jmd":
            conversionRate = (currenciesTable.jmd?.rate) ?? 1
        case "ssp":
            conversionRate = (currenciesTable.ssp?.rate) ?? 1
        case "mzn":
            conversionRate = (currenciesTable.mzn?.rate) ?? 1
        case "tzs":
            conversionRate = (currenciesTable.tzs?.rate) ?? 1
        case "cny":
            conversionRate = (currenciesTable.cny?.rate) ?? 1
        case "kwd":
            conversionRate = (currenciesTable.kwd?.rate) ?? 1
        case "huf":
            conversionRate = (currenciesTable.huf?.rate) ?? 1
        case "ngn":
            conversionRate = (currenciesTable.ngn?.rate) ?? 1
        case "amd":
            conversionRate = (currenciesTable.amd?.rate) ?? 1
        case "bob":
            conversionRate = (currenciesTable.bob?.rate) ?? 1
        case "srd":
            conversionRate = (currenciesTable.srd?.rate) ?? 1
        case "ghs":
            conversionRate = (currenciesTable.ghs?.rate) ?? 1
        case "top":
            conversionRate = (currenciesTable.top?.rate) ?? 1
        case "mnt":
            conversionRate = (currenciesTable.mnt?.rate) ?? 1
        case "nzd":
            conversionRate = (currenciesTable.nzd?.rate) ?? 1
        case "hrk":
            conversionRate = (currenciesTable.hrk?.rate) ?? 1
        case "byn":
            conversionRate = (currenciesTable.byn?.rate) ?? 1
        case "mdl":
            conversionRate = (currenciesTable.mdl?.rate) ?? 1
        case "afn":
            conversionRate = (currenciesTable.afn?.rate) ?? 1
        case "etb":
            conversionRate = (currenciesTable.etb?.rate) ?? 1
        case "sbd":
            conversionRate = (currenciesTable.sbd?.rate) ?? 1
        case "lak":
            conversionRate = (currenciesTable.lak?.rate) ?? 1
        case "cup":
            conversionRate = (currenciesTable.cup?.rate) ?? 1
        case "sar":
            conversionRate = (currenciesTable.sar?.rate) ?? 1
        case "hkd":
            conversionRate = (currenciesTable.hkd?.rate) ?? 1
        case "qar":
            conversionRate = (currenciesTable.qar?.rate) ?? 1
        case "uzs":
            conversionRate = (currenciesTable.uzs?.rate) ?? 1
        case "gmd":
            conversionRate = (currenciesTable.gmd?.rate) ?? 1
        case "bif":
            conversionRate = (currenciesTable.bif?.rate) ?? 1
        case "aoa":
            conversionRate = (currenciesTable.aoa?.rate) ?? 1
        case "khr":
            conversionRate = (currenciesTable.khr?.rate) ?? 1
        case "zar":
            conversionRate = (currenciesTable.zar?.rate) ?? 1
        case "mxn":
            conversionRate = (currenciesTable.mxn?.rate) ?? 1
        case "lyd":
            conversionRate = (currenciesTable.lyd?.rate) ?? 1
        case "iqd":
            conversionRate = (currenciesTable.iqd?.rate) ?? 1
        case "bsd":
            conversionRate = (currenciesTable.bsd?.rate) ?? 1
        case "gnf":
            conversionRate = (currenciesTable.gnf?.rate) ?? 1
        case "hnl":
            conversionRate = (currenciesTable.hnl?.rate) ?? 1
        case "npr":
            conversionRate = (currenciesTable.npr?.rate) ?? 1
        case "czk":
            conversionRate = (currenciesTable.czk?.rate) ?? 1
        case "thb":
            conversionRate = (currenciesTable.thb?.rate) ?? 1
        case "xof":
            conversionRate = (currenciesTable.xof?.rate) ?? 1
        case "egp":
            conversionRate = (currenciesTable.egp?.rate) ?? 1
        case "gel":
            conversionRate = (currenciesTable.gel?.rate) ?? 1
        case "gyd":
            conversionRate = (currenciesTable.gyd?.rate) ?? 1
        case "rwf":
            conversionRate = (currenciesTable.rwf?.rate) ?? 1
        case "lsl":
            conversionRate = (currenciesTable.lsl?.rate) ?? 1
        case "sos":
            conversionRate = (currenciesTable.sos?.rate) ?? 1
        case "krw":
            conversionRate = (currenciesTable.krw?.rate) ?? 1
        case "bgn":
            conversionRate = (currenciesTable.bgn?.rate) ?? 1
        case "pgk":
            conversionRate = (currenciesTable.pgk?.rate) ?? 1
        case "azn":
            conversionRate = (currenciesTable.azn?.rate) ?? 1
        case "uyu":
            conversionRate = (currenciesTable.uyu?.rate) ?? 1
        default:
            break
        }
        return conversionRate
    }
}
