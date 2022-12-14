from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver    

# Create your models here.

class Student(models.Model):
    user = models.OneToOneField(User, null=True, blank=True, on_delete=models.CASCADE )
    # USERNAME_FIELD = None   
    name = models.CharField(max_length=120, null=True, blank=False)
    phone = models.CharField(max_length=120, null=True, blank=False)
    email = models.CharField(max_length=120, null=True, blank=False)
    profile_pic = models.ImageField(default="profile_photo.png", null=True, blank=True)

# @receiver(post_save, sender=User)
# def create_user_profile(sender, instance, created, **kwargs):
#     if created:
#         Profile.objects.create(user=instance)

# @receiver(post_save, sender=User)
# def save_user_profile(sender, instance, **kwargs):
#     instance.profile.save()