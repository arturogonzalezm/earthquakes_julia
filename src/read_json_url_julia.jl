#=
read_json_url_julia:
- Julia version: 1.1.0 (2019-01-21)
- Author: arturogonzalez
- Date: 2019-04-22
=#
#=
using Pkg
Pkg.add("HTTP")
Pkg.add("JSON")
=#
using HTTP, JSON

function main()
    """
    :return: List of places and magnitudes, where magnitude is greater than 1.0.
    """
    resp = HTTP.get("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson")
    str = String(resp.body)
    data = JSON.Parser.parse(str)
    features_data = data["features"]
    # JSON.print(features_data, 2)
    for i in features_data
        place = i["properties"]["place"]
        magnitude = i["properties"]["mag"]
        if magnitude > 1.0
            println(place, " | ", magnitude)
            end
    end
end;
@time main()
