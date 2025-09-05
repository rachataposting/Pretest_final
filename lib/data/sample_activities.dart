import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../enums/activity_category.dart';

class SampleActivities {
  static List<Activity> get activities => [
    Activity(
      title: 'สัมมนา AI เพื่อการศึกษา',
      description: 'เรียนรู้การประยุกต์ใช้ AI ในการพัฒนาการเรียนการสอน เพื่อยกระดับคุณภาพการศึกษาในศตวรรษที่ 21 พร้อมด้วยการสาธิตเครื่องมือ AI ที่ทันสมัย และการแลกเปลี่ยนประสบการณ์จากผู้เชี่ยวชาญด้าน AI Education',
      imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=200&fit=crop',
      organizer: 'คณะวิศวกรรมศาสตร์',
      date: DateTime(2567, 9, 20),
      time: TimeOfDay(hour: 9, minute: 0),
      location: 'หอประชุมใหญ่ มจธ. ธัญบุรี',
      category: ActivityCategory.academic,
    ),
    Activity(
      title: 'แข่งขันฟุตบอลสีจอมความสัมพันธ์',
      description: 'การแข่งขันกีฬาประจำปีของมหาวิทยาลัย เพื่อสร้างความสามัคคีและกีฬาดีเศรษฐ์ดี ระหว่างนักศึกษาทุกคณะ พร้อมกิจกรรมเชียร์และของรางวัลมากมาย รวมถึงการแข่งขันรอบชิงชนะเลิศที่จะจัดขึ้นในสนามหลัก',
      imageUrl: 'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=400&h=200&fit=crop',
      organizer: 'กองพัฒนานักศึกษา',
      date: DateTime(2567, 9, 25),
      time: TimeOfDay(hour: 14, minute: 0),
      location: 'สนามกีฬากลาง มจธ. ธัญบุรี',
      category: ActivityCategory.sport,
    ),
    Activity(
      title: 'นิทรรศการศิลปะนักศึกษา "สีสันแห่งความคิด"',
      description: 'การแสดงผลงานศิลปะจากนักศึกษาทุกคณะ ที่จะมาร่วมแสดงผลงานสร้างสรรค์ในรูปแบบต่างๆ ไม่ว่าจะเป็น จิตรกรรม ประติมากรรม การออกแบบกราฟิก และสื่อผสม เพื่อแสดงถึงความคิดสร้างสรรค์และศักยภาพของเยาวชนไทย',
      imageUrl: 'https://images.unsplash.com/photo-1541961017774-22349e4a1262?w=400&h=200&fit=crop',
      organizer: 'คณะศิลปกรรมศาสตร์',
      date: DateTime(2567, 10, 1),
      time: TimeOfDay(hour: 10, minute: 0),
      location: 'หอศิลป์ มจธ. ธัญบุรี',
      category: ActivityCategory.art,
    ),
    Activity(
      title: 'กิจกรรมอาสาพัฒนาชุมชน "น้อมใจรักษ์แผ่นดิน"',
      description: 'ร่วมพัฒนาชุมชนท้องถิ่นและสร้างสรรค์สังคม โดยการปลูกป่าชายเลน ทำความสะอาดสิ่งแวดล้อม และให้ความรู้แก่เด็กและเยาวชนในชุมชน เพื่อสร้างจิตสำนึกในการอนุรักษ์ธรรมชาติและสิ่งแวดล้อมอย่างยั่งยืน',
      imageUrl: 'https://images.unsplash.com/photo-1559027615-cd4628902d4a?w=400&h=200&fit=crop',
      organizer: 'สโมสรนักศึกษา',
      date: DateTime(2567, 10, 5),
      time: TimeOfDay(hour: 8, minute: 0),
      location: 'ชุมชนบ้านสวน จ.ปทุมธานี',
      category: ActivityCategory.social,
    ),
  ];
}