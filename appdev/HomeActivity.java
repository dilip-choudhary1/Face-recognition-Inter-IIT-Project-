package com.example.facerecognitionattendance;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.content.AbstractThreadedSyncAdapter;
import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.provider.ContactsContract;
import android.provider.MediaStore;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.auth.api.signin.GoogleSignIn;
import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
import com.google.android.gms.auth.api.signin.GoogleSignInClient;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;
import com.google.android.material.tabs.TabLayout;
import com.google.firebase.firestore.DocumentReference;
import com.google.firebase.firestore.DocumentSnapshot;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.firestore.QueryDocumentSnapshot;
import com.google.firebase.firestore.QuerySnapshot;
import com.google.firebase.storage.FirebaseStorage;
import com.google.firebase.storage.StorageReference;
import com.google.firebase.storage.UploadTask;

import java.io.ByteArrayOutputStream;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.jar.Attributes;
import java.util.Calendar;
import java.util.Date;

public class HomeActivity extends AppCompatActivity {
    TextView welcomeText, userEmail;
    Button btnLogout;
    String Name;
    GoogleSignInOptions googleSignInOptions;
    GoogleSignInClient googleSignInClient;
    ImageView imageView;
    Button uploadImgBtn, send;
    private final int CAMERA_REQ_CODE = 100;
    private StorageReference mStorageRef;
    byte [] bb;



    @SuppressLint("SetTextI18n")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);

        //Getting User Id from Main Activity
       /* Bundle p = getIntent().getExtras();
        String yourPreviousPzl =p.getString("currentUserId");*/

        welcomeText = findViewById(R.id.welcomeText);
        //userEmail = findViewById(R.id.userEmail);
        btnLogout = findViewById(R.id.logout);
        imageView = findViewById(R.id.imageView);
        uploadImgBtn = findViewById(R.id.uploadImgBtn);
        send = findViewById(R.id.sendImg);

        Date currentTime = Calendar.getInstance().getTime();

        send.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                StorageReference sr = mStorageRef.child(Name+"/"+ currentTime+".jpg");
                sr.putBytes(bb).addOnSuccessListener(taskSnapshot -> Toast.makeText(HomeActivity.this, "Successfully uploaded", Toast.LENGTH_SHORT))
                        .addOnFailureListener(e -> Toast.makeText(HomeActivity.this, "Failed to Upload", Toast.LENGTH_SHORT));
            }
        });

        // Create a Cloud Storage reference from the app
        mStorageRef = FirebaseStorage.getInstance().getReference();

        uploadImgBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent iCamera = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
                startActivityForResult(iCamera,CAMERA_REQ_CODE);
            }
        });

        FirebaseFirestore db = FirebaseFirestore.getInstance();

        googleSignInOptions = new GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
                .requestEmail()
                .build();

        googleSignInClient = GoogleSignIn.getClient(this, googleSignInOptions);

        GoogleSignInAccount account = GoogleSignIn.getLastSignedInAccount(this);
        if (account != null){
             Name = account.getDisplayName();
            String Email = account.getEmail();

           welcomeText.setText("Welcome, " + Name);
            //userEmail.setText(Email);

        }

        // Create a new user with a first and last name
        Map<String, Object> user = new HashMap<>();
        assert account != null;
        user.put("Name", account.getDisplayName());
        user.put("Email", account.getEmail());

        // Add a new document with a generated ID
        db.collection("users")
                .add(user)
                .addOnSuccessListener(new OnSuccessListener<DocumentReference>() {
                    @Override
                    public void onSuccess(DocumentReference documentReference) {
                        Log.d("TAG", "DocumentSnapshot added with ID: " + documentReference.getId());
                    }
                })
                .addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        Log.w("TAG", "Error adding document", e);
                    }
                });

        //Getting clicked on Logout Button
        btnLogout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                SignOut();
            }
        });
    }

    private void SignOut(){
        googleSignInClient.signOut().addOnCompleteListener(new OnCompleteListener<Void>() {
            @Override
            public void onComplete(@NonNull Task<Void> task) {
                finish();
                startActivity(new Intent(getApplicationContext(), MainActivity.class));

            }
        });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode==RESULT_OK){
            if (requestCode == CAMERA_REQ_CODE){
                // for camera
               Bitmap img = (Bitmap) (data.getExtras().get("data"));
                ByteArrayOutputStream bytes = new ByteArrayOutputStream();
                img.compress(Bitmap.CompressFormat.JPEG,90,bytes);
                bb = bytes.toByteArray();
                imageView.setImageBitmap(img);
            }
        }
    }
}