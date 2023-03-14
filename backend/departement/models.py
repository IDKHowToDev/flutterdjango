from django.db import models

# Create your models here.


class Departement(models.Model):
    name=models.CharField(max_length=255)
    def __str__(self):
        return self.name




class PostDep(models.Model):
    title=models.CharField(max_length=255)
    content=models.CharField(max_length=10000)
    dep=models.ForeignKey(Departement,on_delete=models.CASCADE)

    def __str__(self):
        return self.title
    

