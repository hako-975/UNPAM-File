package com.example.kelompok10;

import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.EditText; 

public class MainActivity extends Activity implements OnClickListener {
	private EditText utsET, uasET, nilaiAkhirET;
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        utsET = (EditText) findViewById(R.id.utsEditText);
        uasET = (EditText) findViewById(R.id.uasEditText);
        nilaiAkhirET = (EditText) findViewById(R.id.nilaiAkhirEditText);
        
        findViewById(R.id.hitungButton).setOnClickListener(this);
        findViewById(R.id.tutupButton).setOnClickListener(this); 
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.activity_main, menu);
        return true;
    }
    
    public void onClick(View v) {
    	switch (v.getId()) {
    	case R.id.hitungButton:
    		double uts=0, uas=0, nilaiAkhir;
    		
    		try {
    			uts = Double.parseDouble(utsET.getText().toString());
    		} catch (Exception ex) {}

    		try {
    			uas = Double.parseDouble(uasET.getText().toString());
    		} catch (Exception ex) {}
    		
    		nilaiAkhir = (uts + uas) / 2;
    		
    		if (nilaiAkhir >= 60) {
    			nilaiAkhirET.setBackgroundResource(R.color.hijau);
    		} else {
    			nilaiAkhirET.setBackgroundResource(R.color.merah);
    		}
    		
    		nilaiAkhirET.setText(Double.toString(nilaiAkhir));
    		break;
    		
    	case R.id.tutupButton:
    		System.exit(0);
    	}
    }
}
