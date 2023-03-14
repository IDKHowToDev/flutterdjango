from django.urls import path
from .views import DepartementAPIView,PostDepAPIView,PostDepByDepartement

urlpatterns = [
    path('departements/', DepartementAPIView.as_view(), name='departement-list'),
    path('postdepartements/', PostDepAPIView.as_view(), name='postdepartement-list'),
    path('postdepartements/<int:departement_id>/', PostDepByDepartement.as_view(), name='postdep_by_departement'),
]
