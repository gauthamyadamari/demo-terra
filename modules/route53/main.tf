resource "aws_route53_zone" "my-test-zone" {
    name = "www.gingerteaoff.netfy.me"
}

resource "aws_route53_record" "example_routing" {
    zone_id = aws_route53_zone.my-test-zone.zone_id
    name = "www.gingerteaoff.netfy.me"
    type = "A"
    ttl = "300"
    records = ["172.31.39.150"]
  
}