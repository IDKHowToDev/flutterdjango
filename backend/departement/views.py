# views.py
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import Departement, PostDep
from .serializer import DepartementSerializer, PostDepSerializer

class DepartementAPIView(APIView):
    def get(self, request):
        depts = Departement.objects.all()
        serializer = DepartementSerializer(depts, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = DepartementSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class PostDepAPIView(APIView):
    def get(self, request):
        posts = PostDep.objects.all()
        serializer = PostDepSerializer(posts, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = PostDepSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    

class PostDepByDepartement(APIView):
    def get(self, request, departement_id):
        try:
            departement = Departement.objects.get(id=departement_id)
        except Departement.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)

        postdeps = departement.postdep_set.all()
        serializer = PostDepSerializer(postdeps, many=True)
        return Response(serializer.data)