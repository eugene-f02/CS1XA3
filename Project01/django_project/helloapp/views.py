from django.shortcuts import render

from django.http import HttpResponse

def hello(request):
        html="<html><body style='background-color: red'>Hello World</body></html>"
        return HttpResponse(html)

def goodbye_world(request):
        html="<html><body style='background-color: blue'>Hello World</body></html>"
        return HttpResponse(html)


