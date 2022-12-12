from django.db import models

# Create your models here.

class Student(models.Model):
    name = models.CharField(max_length=120, null=True, blank=False)
    phone = models.CharField(max_length=120, null=True, blank=False)
    email = models.CharField(max_length=120, null=True, blank=False)