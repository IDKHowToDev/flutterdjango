# serializers.py
from rest_framework import serializers
from .models import Departement, PostDep

class PostDepSerializer(serializers.ModelSerializer):
    class Meta:
        model = PostDep
        fields = ['id', 'title', 'content', 'dep']

class DepartementSerializer(serializers.ModelSerializer):
    posts = PostDepSerializer(many=True, read_only=True)

    class Meta:
        model = Departement
        fields = ['id', 'name', 'posts']

