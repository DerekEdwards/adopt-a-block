FactoryBot.define do
  factory :block do
    name { "Basic Block" }
    description { "The Most Basic Block" }
    polyline { [{"lat":42.34665321465967, "lng":-71.10090343124389}, {"lat":42.111252390260134, "lng":-37.40107541538493}, {"lat":48.64451397385783, "lng":-27.029981665384934}] }
  end
end