from django.contrib import admin

from departement.models import Departement,PostDep
from users.models import UserData

# Register your models here.
admin.site.register(Departement)
admin.site.register(PostDep)
admin.site.register(UserData)