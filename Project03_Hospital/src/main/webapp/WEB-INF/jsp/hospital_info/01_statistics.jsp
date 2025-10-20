<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>MEDIPRIME 병원 - 현황 및 통계</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>
</head>
<body class="bg-gray-50 text-gray-900">

  <div class="max-w-6xl mx-auto px-4 py-12">
    <!-- 페이지 제목 -->
    <h2 class="text-xl sm:text-2xl font-semibold text-gray-900 mb-8 border-b border-gray-200 pb-2">
      병원 현황 및 통계
    </h2>

    <!-- 카드형 차트 -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
      <!-- 인원 현황 -->
      <div class="bg-white p-6 rounded-lg shadow border">
        <h3 class="text-lg font-semibold mb-4 text-gray-800">인원 현황</h3>
        <canvas id="staffChart"></canvas>
      </div>

      <!-- 병상 현황 -->
      <div class="bg-white p-6 rounded-lg shadow border">
        <h3 class="text-lg font-semibold mb-4 text-gray-800">병상 현황</h3>
        <canvas id="bedChart"></canvas>
      </div>

      <!-- 수술 및 검사 실적 -->
      <div class="bg-white p-6 rounded-lg shadow border">
        <h3 class="text-lg font-semibold mb-4 text-gray-800">수술 및 검사 실적</h3>
        <canvas id="surgeryChart"></canvas>
      </div>

      <!-- 환자 수 현황 -->
      <div class="bg-white p-6 rounded-lg shadow border">
        <h3 class="text-lg font-semibold mb-4 text-gray-800">환자 수 현황</h3>
        <canvas id="patientChart"></canvas>
      </div>
    </div>
  </div>

  <script>
    Chart.defaults.font.family = "'Noto Sans KR', 'sans-serif'";
    Chart.defaults.font.size = 16;

    // 인원 현황
    new Chart(document.getElementById('staffChart'), {
      type: 'doughnut',
      data: {
        labels: ['의사직', '간호직', '관리자'],
        datasets: [{
          data: [420, 960, 220],
          backgroundColor: ['#3b82f6', '#10b981', '#f59e0b']
        }]
      },
      options: {
        responsive: true,
        plugins: {
          legend: {
            position: 'bottom',
            labels: { font: { size: 16 } }
          },
          datalabels: {
            color: '#fff',
            font: { weight: 'bold', size: 16 },
            formatter: value => value + '명'
          }
        },
        cutout: '60%'
      },
      plugins: [ChartDataLabels]
    });

    // 병상 현황
    new Chart(document.getElementById('bedChart'), {
      type: 'doughnut',
      data: {
        labels: ['일반병상', '특수병상', '중환자실'],
        datasets: [{
          data: [500, 200, 100],
          backgroundColor: ['#6366f1', '#06b6d4', '#ef4444']
        }]
      },
      options: {
        responsive: true,
        plugins: {
          legend: {
            position: 'bottom',
            labels: { font: { size: 16 } }
          },
          datalabels: {
            color: '#fff',
            font: { weight: 'bold', size: 16 },
            formatter: value => value + '병상'
          }
        },
        cutout: '60%'
      },
      plugins: [ChartDataLabels]
    });

    // 수술 및 검사 실적
    new Chart(document.getElementById('surgeryChart'), {
      type: 'bar',
      data: {
        labels: ['수술 건수', '영상의학 검사', '방사선 치료'],
        datasets: [{
          label: '건수',
          data: [3800, 6200, 900],
          backgroundColor: ['#f97316', '#3b82f6', '#22c55e']
        }]
      },
      options: {
        responsive: true,
        scales: {
          x: { ticks: { font: { size: 16 } } },
          y: { beginAtZero: true, ticks: { font: { size: 16 } } }
        },
        plugins: {
          legend: { display: false },
          datalabels: {
            anchor: 'end',
            align: 'end',
            color: '#333',
            font: { size: 16 },
            formatter: val => val + '건'
          }
        }
      },
      plugins: [ChartDataLabels]
    });

    // 환자 수 현황
    new Chart(document.getElementById('patientChart'), {
      type: 'bar',
      data: {
        labels: ['외래환자', '입원환자'],
        datasets: [{
          label: '명',
          data: [110000, 54000],
          backgroundColor: ['#3b82f6', '#f97316']
        }]
      },
      options: {
        responsive: true,
        scales: {
          x: { ticks: { font: { size: 16 } } },
          y: { beginAtZero: true, ticks: { font: { size: 16 } } }
        },
        plugins: {
          legend: { display: false },
          datalabels: {
            anchor: 'end',
            align: 'end',
            color: '#333',
            font: { size: 16 },
            formatter: val => val.toLocaleString() + '명'
          }
        }
      },
      plugins: [ChartDataLabels]
    });
  </script>

</body>
</html>
