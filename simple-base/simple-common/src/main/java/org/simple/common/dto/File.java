package org.simple.common.dto;


import lombok.Data;

import java.util.Date;

@Data
public class File {

    private Long size;
    private Date updateDate;
    private String key;
}
